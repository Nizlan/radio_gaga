import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier(super.state);
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayer>(
  (ref) => AudioPlayerNotifier(
    AudioPlayer()
      ..setLoopMode(LoopMode.all)
      ..setShuffleModeEnabled(true),
  ),
);

final isPlayerOpen = StateProvider<bool>((ref) => false);
