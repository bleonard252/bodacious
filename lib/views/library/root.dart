import 'dart:ui';

import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LibraryRootView extends StatefulWidget {
  const LibraryRootView({ Key? key }) : super(key: key);

  @override
  State<LibraryRootView> createState() => _LibraryRootViewState();
}

class _LibraryRootViewState extends State<LibraryRootView> {
  double _cPos = 0;
  ScrollController scrollController = ScrollController();
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        const Positioned.fill(child: Material()),
        Positioned(
          left: 0,
          right: 0,
          top: -_cPos,
          child: Image.asset("assets/bubblebg.png",
            fit: BoxFit.fill,
            width: (context.findRenderObject() as RenderBox?)?.size.width ?? MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            //errorBuilder: (context, error, trace) => Container(color: Colors.red),
          ),
        ),
        const Positioned.fill(child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x7f000000),
                Color(0x00000000)
              ]
            )
          ),
        )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 72, sigmaY: 72),
            child: SafeArea(
              bottom: false,
              child: DefaultTabController(
                //initialIndex: 0,
                length: 4,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: TabBar(
                    labelColor: Theme.of(context).textTheme.bodyText2?.color,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(MdiIcons.accountMusic),
                            ),
                            Text("Artists"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(MdiIcons.album),
                            ),
                            Text("Albums"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(MdiIcons.musicBoxMultipleOutline),
                            ),
                            Text("Songs"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(MdiIcons.playlistMusic),
                            ),
                            Text("Playlists"),
                          ],
                        ),
                      ),
                    ],
                    onTap: (_) {
                      // Reset the scroll position.
                      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 250), curve: Curves.elasticIn);
                    },
                  ),
                  body: const TabBarView(children: [
                    Center(child: Icon(MdiIcons.alphaA)),
                    Center(child: Icon(MdiIcons.alphaB)),
                    Center(child: Icon(MdiIcons.alphaC)),
                    Center(child: Icon(MdiIcons.alphaD)),
                    //Center(child: Icon(MdiIcons.alphaE))
                  ])
                ),
              ),
            ),
          )
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  onScroll() {
    setState(() {
      _cPos = scrollController.offset;
    });
  }
  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }
}