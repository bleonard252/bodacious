
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: FrameSize.of(context) ? null : Tooltip(
          message: "Back to Now Playing",
          child: IconButton(
            onPressed: () => widget.setParentState?.call(() {
              try {
                GoRouter.of(context).pop(); 
              } catch(_) {
                context.go("/now_playing");
              }
            }),
            icon: const Icon(MdiIcons.arrowLeft)
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text("CLEAR"),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith((_) => Theme.of(context).colorScheme.onPrimary),
                overlayColor: MaterialStateColor.resolveWith((_) => Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2))
              ),
              onPressed: () async {
                final r = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("This will clear the queue and stop your music."),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("No")),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Yes")),
                  ],
                )) ?? false;
                if (!r) return;
                await player.stop();
                await player.updateQueue([]);
                player.queue.add([]);
                player.mediaItem.add(null);
                ref.refresh(nowPlayingProvider);
              },
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        elevation: 0,
      ),
      body: ListView.builder(
        itemExtent: 72.0,
        controller: controller,
        itemCount: (queue?.entries.length ?? 0),
        itemBuilder: (context, index) {
          return SongWidget(
            queue!.entries[index],
            selected: index == queue.position,
            inQueue: true,
            queueIndex: index,
            onTap: () {
              player.skipToQueueItem(index);
              player.play();
            }
          );
        }
      ),
    );
  }
}