import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        Container(
          width: 240,
          alignment: Alignment.centerLeft,
          color: Colors.green[300],
        ),
        Expanded(child: Builder(builder: (context) => buildNavigator(context)))
      ]);
    } else {
      return Column(children: [
        Expanded(child: Builder(builder: (context) => buildNavigator(context))),
        Container(
          height: 96,
          alignment: Alignment.bottomCenter,
          color: Colors.red[300],
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
      GoRoute(path: "/", builder: (context, state) => const Scaffold(backgroundColor: Colors.red, body: const Center(child: const Text("HOME"))))
    ]
  );
}