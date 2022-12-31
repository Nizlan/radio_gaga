import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer, required this.size});
  final double size;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: audioPlayer.seekToPrevious,
            color: Colors.white,
            iconSize: size / 2,
            icon: const Icon(Icons.skip_previous_rounded)),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            if (!(playing ?? false)) {
              return IconButton(
                onPressed: audioPlayer.play,
                iconSize: size,
                color: Colors.white,
                icon: const Icon(Icons.play_arrow_rounded),
              );
            } else if (processingState == ProcessingState.loading) {
              return const CircularProgressIndicator(
                color: Colors.yellow,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                color: Colors.white,
                iconSize: size,
                onPressed: audioPlayer.pause,
                icon: const Icon(Icons.pause_rounded),
              );
            }
            return Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: size,
            );
          },
        ),
        IconButton(
            onPressed: audioPlayer.seekToNext,
            color: Colors.white,
            iconSize: size / 2,
            icon: const Icon(Icons.skip_next_rounded)),
      ],
    );
  }
}
