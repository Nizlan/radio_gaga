import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../data/models/position_data.dart';

Stream<PositionData> positionDataStream(AudioPlayer audioPlayer) {
  return Rx.combineLatest3(
    audioPlayer.positionStream,
    audioPlayer.bufferedPositionStream,
    audioPlayer.durationStream,
    (position, bufferedPosition, duration) => PositionData(
        position: position,
        bufferedPosition: bufferedPosition,
        duration: duration ?? Duration.zero),
  );
}
