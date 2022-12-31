import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_ga/audio_player/view/big_metadata.dart';

import '../../style.dart';
import '../providers.dart';
import 'audio_attrubutes.dart';
import 'controls.dart';
import 'progress_audio_bar.dart';

class AudioPlayerWidget extends ConsumerWidget {
  final String playlistId;
  final String audioId;
  final int audioSeq;
  const AudioPlayerWidget(this.playlistId, this.audioId, this.audioSeq,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: Style.blueGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AudioAttributes(
              audioPlayer: audioPlayer,
              child: (title, playlistTitle) =>
                  BigMetadata(title: title, playlistTitle: playlistTitle),
            ),
            ProgressAudioBar(audioPlayer: audioPlayer),
            Controls(
              size: 100,
              audioPlayer: audioPlayer,
            )
          ],
        ),
      ),
    );
  }
}
