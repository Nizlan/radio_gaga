import 'package:radio_ga/audio_player/data/models/playlist.dart';

import '../data/models/audio_data.dart';

int getAudioListSeq(List<Playlist> data, int arrSeq, int inArrSeq) {
  int seq = 0;
  for (int arr = 0; arr <= arrSeq; arr++) {
    if (arr < arrSeq) {
      final m = data[arr];
      seq += data[arr].audioList.length;
    } else {
      for (int inArr = 0; inArr < inArrSeq; inArr++) {
        seq++;
      }
    }
  }
  return seq;
}
