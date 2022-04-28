
import 'package:bodacious/main.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QueueView extends ConsumerStatefulWidget {
  final Function(Function())? setParentState;
  const QueueView({Key? key, this.setParentState}) : super(key: key);
  
  @override
  _QueueViewState createState() => _QueueViewState();
}

class _QueueViewState extends ConsumerState<QueueView> {
  late final ScrollController controller = ScrollController(initialScrollOffset: 
    ((ref.read(queueProvider).value?.position?.roundToDouble() ?? 8)*72)-180);
  //bool _hasScrolled = false;

  @override
  Widget build(BuildContext context) {
    final queue = ref.watch(queueProvider).value;
    return Column(
      children: [
        AppBar(
          leading: FrameSize.of(context) ? null : Tooltip(
            message: "Back to Now Playing",
            child: IconButton(
              onPressed: () => widget.setParentState?.call(() => context.go("/now_playing")),
              icon: const Icon(MdiIcons.arrowLeft)
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: 72.0,
            controller: controller,
            itemCount: (queue?.entries.length ?? 0),
            itemBuilder: (context, index) {
              return SongWidget(
                queue!.entries[index],
                selected: index == queue.position,
                inQueue: true,
                onTap: () {
                  player.skipToQueueItem(index);
                  player.play();
                }
              );
            }
          ),
        ),
      ],
    );
  }
}