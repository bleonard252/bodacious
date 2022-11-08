
import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/background/discordrpc.dart';
import 'package:bodacious/background/scrobble.dart';
import 'package:bodacious/drift/database.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/config.dart';
import 'package:bodacious/src/library/indexer.dart';
import 'package:bodacious/src/media/audio_service.dart';
import 'package:bodacious/src/navigate_observer.dart';
import 'package:bodacious/src/online/lastfm.dart';
import 'package:bodacious/views/about.dart';
import 'package:bodacious/views/home.dart';
import 'package:bodacious/views/library/details/album.dart';
import 'package:bodacious/views/library/details/artist.dart';
import 'package:bodacious/views/library/root.dart';
import 'package:bodacious/views/logs.dart';
import 'package:bodacious/views/main_menu.dart';
import 'package:bodacious/views/mpv_crash.dart';
import 'package:bodacious/views/now_playing.dart';
import 'package:bodacious/views/settings/library.dart';
import 'package:bodacious/views/settings/personalization.dart';
import 'package:bodacious/views/settings/root.dart';
import 'package:bodacious/views/settings/services.dart';
import 'package:bodacious/views/splash.dart';
import 'package:bodacious/widgets/now_playing.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/now_playing_sidebar.dart';
import 'package:dart_discord_rpc/dart_discord_rpc.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flinq/flinq.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lastfm/lastfm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinelogger/pinelogger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
//import 'package:bitsdojo_window/bitsdojo_window.dart';

late final BoDatabase db;
late final Config config;

late final BodaciousAudioHandler player;
late final DiscordRPC discord;
final APIKeys apiKeys = APIKeys();

final Pinelogger appLogger = Pinelogger("Bodacious");

late final ReplaySubject<String> errors = ReplaySubject();

void main() async {
  runApp(const SplashScreen());
  //try {DartVLC.initialize();} finally {}
  if (Platform.isWindows || Platform.isLinux) {
    DiscordRPC.initialize();
    discord = DiscordRPC(applicationId: const String.fromEnvironment("DISCORD_APP_ID"));
    discord.start(autoRegister: true);
  }
  db = BoDatabase();
  config = Config(await SharedPreferences.getInstance());
  await db.executor.ensureOpen(db);

  if (Platform.isLinux && Process.runSync("which", ["mpv"]).exitCode != 0) {
    return runApp(const MPVMissingCrash());
  }

  final _bgsinitLogger = appLogger.independentChild("BackgroundPlayer.init");
  try {
    player = await AudioService.init<BodaciousAudioHandler>(
      builder: () {
        if (Platform.isAndroid || Platform.isIOS || Platform.isLinux || Platform.isWindows || kIsWeb) {
          return JustAudioHandler();
        } else {
          _bgsinitLogger.error("Platform not supported", error: Platform.operatingSystem);
          throw UnsupportedError("Platform not supported");
        }
      },
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'xyz.u1024256.bodacious.player',
        androidNotificationChannelName: 'Audio player',
        androidNotificationChannelDescription: "Bodacious puts your music in the notifications with this, which also lets it play in the background.",
        //androidNotificationOngoing: true,
        androidNotificationIcon: "drawable/notification",
        androidStopForegroundOnPause: true,
        notificationColor: Colors.amber,
      )
    );
  // ignore: empty_catches
  } on UnsupportedError {
  } on MissingPluginException {
    _bgsinitLogger.warning("Platform not supported", error: Platform.operatingSystem);
  }
  nowPlayingProvider = StreamProvider<TrackMetadata>((ref) async* {
    final log = appLogger.independentChild("nowPlayingProvider");
    final stream = player.mediaItem;
    final nothingPlaying = TrackMetadata.empty();
    yield nothingPlaying;
    await for (final update in stream) {
      log.verbose("\"Now Playing\" update received, processing");
      if (update == null) continue;
      if (update is BodaciousMediaItem) {
        //yield update.parent;
        continue;
      }
      if (update.id.contains("://") && !update.id.startsWith("file:///")) {
        // if (kDebugMode) {
        //   print(update.id+" is not a supported URI.");
        // }
        log.warning("Unsupported URI encountered in update.", error: update.id);
        yield nothingPlaying.copyWith(title: Uri.tryParse(update.id)?.pathSegments.lastOrNull);
      }
      if (!ref.state.hasValue) yield nothingPlaying.copyWith(uri: Uri.file(update.id));
      // final _dbEntry = await songStore.findFirst(db, finder: Finder(filter: Filter.equals('uri', Uri.file(update.id).toString())));
      // if (kDebugMode) {
      //   final value = (await songStore.find(db)).map((e) => e.value);
      // }

      final TrackMetadata? _dbEntry = await (db.select(db.trackTable)
      ..where((tbl) => tbl.uri.equalsValue(Uri.file(update.id)) | tbl.uri.equalsValue(Uri.parse(update.id)))
      ..limit(1)
      ).getSingleOrNull();
      
      if (_dbEntry != null) {
        player.mediaItem.add(_dbEntry.copyWith(duration: update.duration).asMediaItem());
        yield _dbEntry;
      } else {
        yield nothingPlaying.copyWith(uri: Uri.file(update.id));
      }
    }
  });
  final discordLog = appLogger.independentChild("DiscordRPC");
  if (Platform.isWindows || Platform.isLinux) startDiscordRpc().catchError((error) {discordLog.error(error);}); // this just runs in the background
  final lastFmLog = appLogger.independentChild("LastFM");
  startLastFmNowPlaying().catchError((error) {lastFmLog.error(error);});
  startScrobbling().catchError((error) {lastFmLog.child("scrobble").error(error);});
  queueProvider = StreamProvider<Queue<TrackMetadata>>((ref) async* {
    final log = appLogger.independentChild("nowPlayingProvider").child("queueProvider");
    final stream = player.queue;
    yield Queue(entries: []);
    await for (final update in stream) {
      if (update.isEmpty) yield Queue(entries: []);
      
      if (listEquals(update,ref.state.value?.entries.map((value) => value.asMediaItem()).toList())) continue;
        // if the update is the same as the existing queue, don't update it
      final List<Future<TrackMetadata?>> futures = [];
      for (final update in update) {
        if (update is BodaciousMediaItem) {
          futures.add(Future.value(update.parent));
          continue;
        }
        if (update.id.contains("://") && !update.id.startsWith("file:///")) {
          // if (kDebugMode) {
          //   print(update.id+" is not a supported URI.");
          // }
          log.warning("Unsupported URI found in queue", error: update.id);
          continue;
        }
        // final _dbEntry = await songStore.findFirst(db, finder: Finder(filter: Filter.equals('uri', Uri.file(update.id).toString())));
        // if (kDebugMode) {
        //   final value = (await songStore.find(db)).map((e) => e.value);
        // }

        final Future<TrackMetadata?> _dbEntry = (db.select(db.trackTable)
        ..where((tbl) => tbl.uri.equalsValue(Uri.file(update.id)) | tbl.uri.equalsValue(Uri.parse(update.id)))
        ..limit(1)
        ).getSingleOrNull();
        futures.add(_dbEntry);
      }
      
      yield Queue(entries: (await Future.wait<TrackMetadata?>(futures)).whereType<TrackMetadata>().toList(), position: player.currentIndex);
    }
  });

  runApp(const ProviderScope(
    child: MyApp(),
  ));

  TheIndexer.spawn().catchError((error, stack) => appLogger.independentChild("Indexer").error(error, stackTrace: stack));

  if (config.lastFmToken != null && apiKeys.lastfmApiKey != null) {
    lastfm = LastFMAuthorized(
      apiKeys.lastfmApiKey!,
      secret: apiKeys.lastfmSecret!,
      sessionKey: config.lastFmToken!,
      username: config.lastFmUsername!,
      userAgent: "Bodacious/0.5.0 <https://github.com/bleonard252/bodacious>"
    );
  }

  // doWhenWindowReady(() {
  //   const initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.title = "Bodacious";
  //   appWindow.show();
  // });

}

//final nowPlayingProvider = StateNotifierProvider<NowPlayingNotifier, TrackMetadata>((ref) => NowPlayingNotifier());
late final StreamProvider<TrackMetadata> nowPlayingProvider;
late final StreamProvider<Queue<TrackMetadata>> queueProvider;

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bodacious',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
        //useMaterial3: false,
        applyElevationOverlayColor: false,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.amber : states.contains(MaterialState.disabled) ? ThemeData.dark().disabledColor : Colors.grey),
          trackColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.amber.shade400 : states.contains(MaterialState.disabled) ? ThemeData.dark().disabledColor.withOpacity(0.8) : Colors.grey.shade400)
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber, backgroundColor: ThemeData.dark().scaffoldBackgroundColor, primaryColorDark: Colors.amber, brightness: Brightness.dark),
      ).copyWith(
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.amber : states.contains(MaterialState.disabled) ? ThemeData.dark().disabledColor : Colors.grey),
          trackColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.amber.shade400 : states.contains(MaterialState.disabled) ? ThemeData.dark().disabledColor.withOpacity(0.8) : Colors.grey.shade400)
        ),
        applyElevationOverlayColor: false,
        //useMaterial3: false,
      ),
      home: Builder(
        builder: (context) {
          return FrameSize(
            largeFrame: MediaQuery.of(context).size.width >= 512,
            child: OuterFrame(),
            //metadataProvider: NowPlayingNotifier(),
          );
        }
      )
    );
  }

  @override
  void onWindowClose() async {
    await player.stop();
    super.onWindowClose();
  }
}

class OuterFrame extends StatelessWidget {
  OuterFrame({ Key? key }) : super(key: key);

  final GlobalKey<State<Router>> navigatorKey = GlobalKey(debugLabel: "Nested Router key");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          final location = goRouter.location.split("/");
          //appLogger.independentChild("Indexer").debug(goRouter.location, error: location);
          if (goRouter.location == "/") return true;
          location.removeLast();
          try {
            goRouter.pop();
          } catch(e) {
            goRouter.go("/"+location.join("/"));
          }
          if (goRouter.location == "/") {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(const SnackBar(content: Text("Tap back again to close Bodacious")));
          }
          return false;
        },
        child: (FrameSize.of(context)) ? Column(
          children: [
            Expanded(
              child: Row(children: [
                StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      width: 240,
                      child: Material(
                        color: Theme.of(context).colorScheme.surface,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: SafeArea(
                                      bottom: false,
                                      child: ListTile(
                                        leading: const Icon(MdiIcons.home, size: 36),
                                        title: const Text("Home"),
                                        selected: goRouter.location == "/",
                                        onTap: () {
                                          goRouter.go("/");
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  ),
                                  SliverToBoxAdapter(
                                    child: ListTile(
                                      leading: const Icon(MdiIcons.musicBoxMultiple, size: 36),
                                      title: const Text("Library"),
                                      selected: goRouter.location.startsWith("/library"),
                                      onTap: () {
                                        goRouter.go("/library");
                                        setState(() {});
                                      },
                                    )
                                  ),
                                  const SliverList(delegate: SliverChildListDelegate.fixed([])),
                                ]
                              ),
                            ),
                            if (config.wideCompactNowPlaying) const NowPlayingSidebar()
                          ],
                        ),
                      )
                    );
                  }
                ),
                Expanded(
                  child: ClipRect(
                    child: Builder(builder: (context) => buildNavigator(context)),
                  ),
                )
              ]),
            ),
            if (!config.wideCompactNowPlaying) const SafeArea(top: false, child: NowPlayingBar())
          ],
        ) : Column(children: [
          Expanded(child: ClipRect(child: Builder(builder: (context) => buildNavigator(context)))),
          SafeArea(
          top: false,
          child: StreamBuilder(
            stream: _observer.stream,
            builder: (context, snapshot) {
              final shouldBeSelected = goRouter.location == "/menu" || goRouter.location == "/" || goRouter.location.startsWith("/library");
              return Column(children: [
                if (!goRouter.location.startsWith("/now_playing")) const NowPlayingBar(),
                BottomNavigationBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  currentIndex:
                    goRouter.location == "/" ? 0 :
                    goRouter.location.startsWith("/library") ? 1
                    : 2,
                  // all this for a drop of blood?
                  selectedItemColor: shouldBeSelected
                  ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor ?? Theme.of(context).colorScheme.primary
                  : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ?? Theme.of(context).unselectedWidgetColor,
                  selectedIconTheme: shouldBeSelected
                  ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme
                  : Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
                  selectedFontSize: shouldBeSelected
                  ? Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle?.fontSize ?? 14.0
                  : Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle?.fontSize ?? 12.0,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(MdiIcons.home), label: "Home"),
                    BottomNavigationBarItem(icon: Icon(MdiIcons.musicBoxMultiple), label: "Library"),
                    BottomNavigationBarItem(icon: Icon(MdiIcons.menu), label: "Menu"),
                    //BottomNavigationBarItem(icon: SizedBox(width: 0), label: "")
                  ],
                  onTap: (i) {
                    if (i == 0) { // Home
                      goRouter.go("/");
                    } else if (i == 1) { // Library
                      goRouter.go("/library");
                    } else if (i == 2) {
                      goRouter.push("/menu");
                    }
                  },
                )
              ]);
            }
          ),
        )
        ])
      ),
    );
  }

  Widget buildNavigator(BuildContext context) {
    return Router(
      key: navigatorKey,
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
    );
  }

  static final _observer = NavigationNotifier();

  static final goRouter = GoRouter(
    //initialLocation: "/",
    routes: [
      GoRoute(path: "/", builder: (context, state) => const HomeView()),
      GoRoute(path: "/library", builder: (context, state) => const LibraryRootView(), routes: [
        // GoRoute(path: "albums/:artistName/:name", builder: (context, state) => AlbumDetailsView(album: state.extra as AlbumMetadata)),
        // GoRoute(path: "artists/:name", builder: (context, state) => ArtistDetailsView(artist: state.extra as ArtistMetadata))
        GoRoute(path: ":artistId", builder: (context, state) => ArtistDetailsWrapper(id: state.params["artistId"]!, data: state.extra), routes: [
          GoRoute(path: ":albumId", builder: (context, state) => AlbumDetailsWrapper(id: state.params["albumId"]!, data: state.extra), routes: [
            //TODO: track metadata page
          ])
        ])
      ]),
      GoRoute(path: "/menu", builder: (context, state) => const MobileMainMenu()),
      GoRoute(path: "/about", builder: (context, state) => const AboutScreen()),
      GoRoute(path: "/licenses", builder: (context, state) => LicensePage(
        applicationName: "Bodacious",
        applicationIcon: Image.asset("assets/brand/ic_foreground.png", fit: BoxFit.contain),
        applicationLegalese: "Copyright 2022 Blake Leonard. Licensed under the MIT license.",
      )),
      //GoRoute(path: "/error_list", builder: (context, state) => const ErrorListView()),
      GoRoute(path: "/logs", builder: (context, state) => const LogView()),
      GoRoute(path: "/now_playing", builder: (context, state) => const NowPlayingView()),
      GoRoute(path: "/settings", builder: (context, state) => const SettingsHome(), routes: [
        GoRoute(path: "library", builder: (context, state) => const LibrarySettingsView()),
        GoRoute(path: "personalization", builder: (context, state) => const PersonalizationSettingsView()),
        GoRoute(path: "services", builder: (context, state) => const OnlineServicesSettingsView()),
      ])
    ],
    observers: [
      _observer
    ]
  );
}