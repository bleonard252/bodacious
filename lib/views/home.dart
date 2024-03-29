import 'dart:ui';

import 'package:bodacious/views/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/frame_size.dart';
import '../widgets/indexer_progress.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String query = "";
  get isSearching => query != "";
  TextEditingController searchBoxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: Material()),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Image.asset("assets/bubblebg.png",
            fit: BoxFit.fill,
            //width: (context.findRenderObject() as RenderBox?)?.size.width ?? MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            //errorBuilder: (context, error, trace) => Container(color: Colors.red),
          ),
        ),
        Positioned.fill(child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).brightness == Brightness.light ? const Color(0x7fffffff) : const Color(0x7f000000),
                const Color(0x00000000)
              ]
            )
          ),
        )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 72, sigmaY: 72),
            blendMode: BlendMode.src,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverAppBar(
                  floating: true,
                  backgroundColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.scrolledUnder) ? Theme.of(context).scaffoldBackgroundColor.withAlpha(127) : Colors.transparent),
                  primary: true,
                  elevation: 0,
                  title: TextField(
                    controller: searchBoxController,
                    onChanged: (value) {
                      if (!isSearching && value.length > 1) {
                        setState(() => query = value);
                      } else {
                        Future.delayed(const Duration(seconds: 1)).then((_) async {
                          if (searchBoxController.value.text != value) return;
                          setState(() => query = value);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.background.withOpacity(0.4),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      prefixIcon: query.split(" ").contains("is:track") || query.split(" ").contains("is:song") ? const Icon(MdiIcons.musicNote)
                      : query.split(" ").contains("is:album") ? const Icon(MdiIcons.album)
                      : query.split(" ").contains("is:artist") ? const Icon(MdiIcons.accountCowboyHat) // easter egg :)
                      : const Icon(MdiIcons.magnify),
                      suffixIcon: isSearching ? IconButton(
                        icon: const Icon(MdiIcons.close),
                        tooltip: "Clear search",
                        onPressed: () {
                          setState(() {
                            query = "";
                            searchBoxController.clear();
                          });
                        },
                      ) : null,
                      hintText: "Search your music..."
                    ),
                  ),
                  actions: [
                    if (FrameSize.of(context)) Builder(
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ActionChip(
                            avatar: const Icon(MdiIcons.menuDown),
                            backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.4),
                            label: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(MdiIcons.account),
                            ),
                            onPressed: () {
                              final RenderBox button = context.findRenderObject()! as RenderBox;
                              final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
                              const Offset offset = Offset(-12, 48);
                              final RelativeRect position = RelativeRect.fromRect(
                                Rect.fromPoints(
                                  button.localToGlobal(offset, ancestor: overlay),
                                  button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
                                ),
                                Offset.zero & overlay.size,
                              );
                              showMenu(
                                context: context,
                                position: position,
                                items: const [
                                  PopupMenuItem(
                                    child: Text("Settings"),
                                    value: "settings"
                                  ),
                                  PopupMenuItem(
                                    child: Text("Logs"),
                                    value: "logs"
                                  ),
                                  PopupMenuItem(
                                    child: Text("About"),
                                    value: "about"
                                  )
                                ],
                              ).then((value) {
                                switch (value) {
                                  case "settings":
                                    context.go("/settings");
                                    break;
                                  case "logs":
                                    context.go("/logs");
                                    break;
                                  case "about":
                                    context.go("/about");
                                    break;
                                  default:
                                }
                              });
                            },
                          ),
                        );
                      }
                    )
                  ],
                ),
                if (!isSearching) SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).disabledColor,
                          style: BorderStyle.solid
                        )
                      ),
                      child: ClipRRect(
                        child: const IndexerProgressWidget(),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
              body: (isSearching) ? SearchResultsView(
                query: query,
                reSearch: (newQuery) {
                  searchBoxController.text = newQuery;
                  setState(() => query = newQuery);
                },
              )
              : Container(),
              floatHeaderSlivers: false,
            )
          )
        )
      ]
    );
  }
}