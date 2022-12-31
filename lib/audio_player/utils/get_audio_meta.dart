import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/audio_player/data/models/extended_media_item.dart';

ExtendedMediaItem? getAudioMeta(SequenceState? sequenceState) {
  final metadata = sequenceState?.currentSource?.tag as ExtendedMediaItem?;
  return metadata;
}
