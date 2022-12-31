import 'package:just_audio/just_audio.dart';

import '../../../constants.dart';
import '../models/audio_data.dart';
import '../models/extended_media_item.dart';

List<UriAudioSource> networkAudio({
  required List<AudioData> data,
  required String playlistId,
  required String album,
  required String playlistTitle,
}) {
  List<UriAudioSource> uriList = [];

  for (int i = 0; i < data.length; i++) {
    uriList.add(
      AudioSource.uri(
        Uri.parse(
          '${APIConst.baseUrl}/audioSource/$album/${data[i].filename}',
        ),
        tag: ExtendedMediaItem(
            id: data[i].filename,
            title: data[i].title,
            playlistId: playlistId,
            playlistTitle: playlistTitle,
            audioSeq: i),
      ),
    );
  }
  return uriList;
}
