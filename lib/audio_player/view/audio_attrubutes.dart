import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../data/models/extended_media_item.dart';
import 'mediadata_widget.dart';

class AudioAttributes extends StatelessWidget {
  final MediaDataWidget Function(String title, String playlistTitle) child;
  final AudioPlayer audioPlayer;
  const AudioAttributes(
      {Key? key, required this.child, required this.audioPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) {
          return const SizedBox();
        }
        final metadata = state!.currentSource!.tag as ExtendedMediaItem;
        return child(metadata.title, metadata.playlistTitle);
      },
    );
  }
}
