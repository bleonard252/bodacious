import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());

  // doWhenWindowReady(() {
  //   const initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.title = "Bodacious";
  //   appWindow.show();
  // });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bodacious',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: OuterFrame()
    );
  }
}
class OuterFrame extends StatelessWidget {
  OuterFrame({ Key? key }) : super(key: key);

  final GlobalKey<State<Router>> navigatorKey = GlobalKey(debugLabel: "Nested Router key");

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 480) {
      return Row(children: [
        StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: 240,
              child: Material(
                child: NestedScrollView(
                  headerSliverBuilder: (context, what) => [
                    SliverToBoxAdapter(
                      child: ListTile(
                        leading: const Icon(MdiIcons.home, size: 36),
                        title: const Text("Home"),
                        selected: goRouter.location == "/",
                        onTap: () {
                          goRouter.go("/");
                          setState(() {});
                        },
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
      ]);
    } else {
      return Column(children: [
        Expanded(child: Builder(builder: (context) => buildNavigator(context))),
        StatefulBuilder(
          builder: (context, setState) {
            return BottomNavigationBar(
              currentIndex: 
              goRouter.location == "/" ? 0 :
              goRouter.location.startsWith("/library") ? 1 :
              goRouter.location == "/menu" ? 2 : -1,
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
                setState(() {});
              },
            );
          }
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

  static final goRouter = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Scaffold(backgroundColor: Colors.red, body: Center(child: Text("HOME")))),
      GoRoute(path: "/library", builder: (context, state) => const Scaffold(backgroundColor: Colors.green, body: Center(child: Text("LIBRARY")))),
      GoRoute(path: "/menu", builder: (context, state) => const Scaffold(backgroundColor: Colors.red, body: Center(child: Text("MAIN MENU"))))
    ]
  );
}