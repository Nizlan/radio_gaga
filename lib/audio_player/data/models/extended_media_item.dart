import 'package:just_audio_background/just_audio_background.dart';

class ExtendedMediaItem extends MediaItem {
  final String playlistTitle;
  final String playlistId;
  final int audioSeq;
  ExtendedMediaItem({
    required super.id,
    required super.title,
    required this.playlistTitle,
    required this.playlistId,
    required this.audioSeq,
  });
}
