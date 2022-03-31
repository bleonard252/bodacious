
import 'package:audio_service/audio_service.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/library/indexer.dart';
import 'package:bodacious/src/library/init_db.dart';
import 'package:bodacious/src/media/audio_service.dart';
import 'package:bodacious/src/metadata/provider.dart';
import 'package:bodacious/src/navigate_observer.dart';
import 'package:bodacious/views/library/root.dart';
import 'package:bodacious/views/main_menu.dart';
import 'package:bodacious/views/now_playing.dart';
import 'package:bodacious/views/settings/library.dart';
import 'package:bodacious/views/settings/root.dart';
import 'package:bodacious/widgets/now_playing.dart';
import 'package:bodacious/widgets/now_playing_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sembast/sembast.dart';
//import 'package:bitsdojo_window/bitsdojo_window.dart';

late Database db;

late final AudioPlayer player;
WidgetRef? playerBackgroundRef;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await loadDatabase();
  player = AudioPlayer();

  await AudioService.init(
    builder: () => BodaciousBackgroundService(player),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'xyz.u1024256.bodacious.player',
      androidNotificationChannelName: 'Audio player',
      androidNotificationChannelDescription: "Bodacious puts your music in the notifications with this, which also lets it play in the background.",
      androidNotificationOngoing: true,
      androidNotificationIcon: "drawable/notification",
      androidStopForegroundOnPause: true,
      notificationColor: Colors.amber,
    )
  );

  runApp(const ProviderScope(
    child: MyApp()
  ));

  TheIndexer.spawn().then((_) async {
    await db.close();
    db = await loadDatabase();
  });

  // doWhenWindowReady(() {
  //   const initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.title = "Bodacious";
  //   appWindow.show();
  // });

}

final nowPlayingProvider = StateNotifierProvider<NowPlayingNotifier, TrackMetadata>((ref) => NowPlayingNotifier());

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    playerBackgroundRef = ref;
    return MaterialApp(
      title: 'Bodacious',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
        //useMaterial3: false,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber, brightness: Brightness.dark),
        //useMaterial3: false,
      ),
      home: NowPlayingData(
        child: OuterFrame(),
        player: player,
        //metadataProvider: NowPlayingNotifier(),
      )
    );
  }
}
class OuterFrame extends StatelessWidget {
  OuterFrame({ Key? key }) : super(key: key);

  final GlobalKey<State<Router>> navigatorKey = GlobalKey(debugLabel: "Nested Router key");

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 480) {
      return Column(
        children: [
          Expanded(
            child: Row(children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return SizedBox(
                    width: 240,
                    child: Material(
                      color: Theme.of(context).colorScheme.surface,
                      child: NestedScrollView(
                        headerSliverBuilder: (context, what) => [
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
                          )
                        ],
                        body: ListView()
                      ),
                    )
                  );
                }
              ),
              Expanded(child: Builder(builder: (context) => buildNavigator(context)))
            ]),
          ),
          const SafeArea(top: false, child: NowPlayingBar())
        ],
      );
    } else {
      return Column(children: [
        Expanded(child: Builder(builder: (context) => buildNavigator(context))),
        SafeArea(
          top: false,
          child: StreamBuilder(
            stream: _observer.stream,
            builder: (context, snapshot) {
              final shouldBeSelected = goRouter.location == "/menu" || goRouter.location == "/" || goRouter.location.startsWith("/library");
              return Column(children: [
                if (goRouter.location != "/now_playing") const NowPlayingBar(),
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
      ]);
    }
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
    initialLocation: "/menu",
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Scaffold(backgroundColor: Colors.red, body: Center(child: Text("HOME")))),
      GoRoute(path: "/library", builder: (context, state) => const LibraryRootView()),
      GoRoute(path: "/menu", builder: (context, state) => const MobileMainMenu()),
      GoRoute(path: "/now_playing", builder: (context, state) => const NowPlayingView()),
      GoRoute(path: "/settings", builder: (context, state) => const SettingsHome(), routes: [
        GoRoute(path: "library", builder: (context, state) => const LibrarySettingsView()),
      ])
    ],
    observers: [
      _observer
    ]
  );
}