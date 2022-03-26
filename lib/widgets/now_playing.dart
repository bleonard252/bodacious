import 'package:bodacious/widgets/now_playing_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = NowPlayingData.of(context);
    return Material(
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildTrackInfo(data!, context),
          MediaQuery.of(context).size.width > 480 ? SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  const Tooltip(
                    message: "Previous",
                    child: IconButton(onPressed: null, icon: Icon(MdiIcons.skipBackward))
                  ),
                  buildPlayPauseButton(data),
                  const Tooltip(
                    message: "Next",
                    child: IconButton(onPressed: null, icon: Icon(MdiIcons.skipForward))
                  )
                ])
              ],
            ),
          ) : buildPlayPauseButton(data),
        ],
      ),
    );
  }

  Widget buildPlayPauseButton(NowPlayingData data) {
    return StreamBuilder(
      stream: data.player?.playingStream,
      builder: (context, snap) => snap.data == true ? Tooltip(
        message: "Pause",
        child: IconButton(onPressed: () {
          assert(data.player != null && data.player?.audioSource != null);
          if (data.player == null || data.player?.audioSource == null) return;
          data.player!.pause();
        }, icon: const Icon(MdiIcons.pause))
      ) : Tooltip(
        message: "Play",
        child: IconButton(onPressed: () {
          assert(data.player != null);
          if (data.player == null) return;
          if (data.player!.audioSource == null) {
            FilePicker.platform.pickFiles(
              type: FileType.audio,
              withReadStream: true,
              allowCompression: false,
              allowMultiple: false
            ).then((file) {
              if (file == null || file.files.isEmpty) return;
              data.player!.setAudioSource(AudioSource.uri(Uri.file(file.files.single.path!)));
              data.player!.play();
            });
          } else {
            data.player!.play();
          }
        }, icon: const Icon(MdiIcons.play))
      ),
    );
  }

  Widget buildTrackInfo(NowPlayingData npdata, BuildContext context) {
    final data = npdata.player;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Image(image: )
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 64,
            width: 64,
            child: Center(
              child: Icon(MdiIcons.musicBoxOutline, color: Colors.grey[700])
            ),
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data?.audioSource is UriAudioSource ? (data?.audioSource as UriAudioSource).uri.pathSegments.last : "Song Title"),
              Text.rich(const TextSpan(children: [
                TextSpan(text: "Artist"),
                // WidgetSpan(child: SizedBox(width: 12)),
                // TextSpan(text: "Album"),
              ]), style: Theme.of(context).textTheme.caption)
            ],
          ),
        )
      ],
    );
  }
}