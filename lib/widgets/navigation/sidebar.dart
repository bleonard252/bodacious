import 'package:bodacious/main.dart';
import 'package:bodacious/src/navigate_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../now_playing_sidebar.dart';

class SidebarNavigator extends ConsumerWidget {
  final GoRouter goRouter;
  const SidebarNavigator(this.goRouter, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = appLogger.independentChild("SidebarNavigator");
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(MdiIcons.arrowLeft),
                              onPressed: goRouter.canPop() ? () {
                                try {
                                  goRouter.pop();
                                } catch(e) {
                                  logger.warning("Failed to go back, going home instead", error: e);
                                  try {
                                    goRouter.go("/");
                                  } catch(e) {
                                    logger.error("Failed to go back to home page", error: e);
                                  }
                                }
                              } : null,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text("B O D A C I O U S",
                                softWrap: true,
                                style: TextStyle(
                                  //fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary
                                ),
                                textAlign: TextAlign.justify,
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SafeArea(
                      bottom: false,
                      child: ListTile(
                        leading: const Icon(MdiIcons.home, size: 36),
                        title: const Text("Home"),
                        selected: goRouter.location == "/",
                        onTap: () {
                          goRouter.go("/");
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
}