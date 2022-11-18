import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../now_playing.dart';

class BottomAppBarNavigator extends ConsumerWidget {
  final GoRouter goRouter;
  const BottomAppBarNavigator(this.goRouter, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
}