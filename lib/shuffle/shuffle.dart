import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:radio_ga/audio_player/providers.dart';

class Shuffle {
  static const box = 'shuffle';
  static const val = 'shuffle';

  static Future<bool> get(WidgetRef ref) async {
    final player = ref.read(audioPlayerProvider);
    var b = await Hive.openBox(box);
    bool? shuffle = b.get(val);
    if (shuffle == null) {
      await b.put(val, true);
      shuffle = b.get(val);
    }
    bool nonNullShuffle = shuffle ?? true;

    await player.setShuffleModeEnabled(nonNullShuffle);

    return nonNullShuffle;
  }

  static Future<void> set(WidgetRef ref) async {
    final player = ref.read(audioPlayerProvider);
    final shuffle = _shuffleEnabled(ref);
    var b = await Hive.openBox(box);
    await b.put(val, !shuffle);
    await player.setShuffleModeEnabled(!shuffle);
  }

  static bool _shuffleEnabled(WidgetRef ref) {
    return ref.read(audioPlayerProvider).shuffleModeEnabled;
  }
}
