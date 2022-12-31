import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../data/models/position_data.dart';
import '../utils/position_data_stream.dart';

class ProgressAudioBar extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final bool? isSmall;
  const ProgressAudioBar({super.key, required this.audioPlayer, this.isSmall});

  @override
  Widget build(BuildContext context) {
    final small = isSmall ?? false;
    return StreamBuilder<PositionData>(
      stream: positionDataStream(audioPlayer),
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return ProgressBar(
            thumbRadius: 7,
            progressBarColor: Colors.yellow,
            thumbColor: Colors.yellow,
            thumbGlowColor: Colors.yellow,
            timeLabelLocation: small ? TimeLabelLocation.none : null,
            timeLabelTextStyle: const TextStyle(color: Colors.white),
            progress: positionData?.position ?? Duration.zero,
            buffered: positionData?.bufferedPosition ?? Duration.zero,
            total: positionData?.duration ?? Duration.zero,
            onSeek: audioPlayer.seek);
      },
    );
  }
}
