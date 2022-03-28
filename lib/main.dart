import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/metadata/provider.dart';
import 'package:bodacious/src/navigate_observer.dart';
import 'package:bodacious/views/now_playing.dart';
import 'package:bodacious/widgets/now_playing.dart';
import 'package:bodacious/widgets/now_playing_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp()
  ));

  // doWhenWindowReady(() {
  //   const initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.title = "Bodacious";
  //   appWindow.show();
  // });

}

final player = AudioPlayer();
final nowPlayingProvider = StateNotifierProvider<NowPlayingNotifier, TrackMetadata>((ref) => NowPlayingNotifier());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bodacious',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
          const SafeArea(top: false, child: NowPlaying())
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
              return Column(children: [
                if (goRouter.location != "/now_playing") const NowPlaying(),
                BottomNavigationBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  currentIndex:
                    goRouter.location == "/" ? 0 :
                    goRouter.location.startsWith("/library") ? 1 :
                    2,
                  selectedItemColor: goRouter.location == "/menu" ? null : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                  selectedIconTheme: goRouter.location == "/menu" ? null : Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(MdiIcons.home), label: "Home"),
                    BottomNavigationBarItem(icon: Icon(MdiIcons.musicBoxMultiple), label: "Library"),
                    BottomNavigationBarItem(icon: Icon(MdiIcons.menu), label: "Menu")
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
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Scaffold(backgroundColor: Colors.red, body: Center(child: Text("HOME")))),
      GoRoute(path: "/library", builder: (context, state) => const Scaffold(backgroundColor: Colors.green, body: Center(child: Text("LIBRARY")))),
      GoRoute(path: "/menu", builder: (context, state) => const Scaffold(backgroundColor: Colors.blue, body: Center(child: Text("MAIN MENU")))),
      GoRoute(path: "/now_playing", builder: (context, state) => const NowPlayingView())
    ],
    observers: [
      _observer
    ]
  );
}