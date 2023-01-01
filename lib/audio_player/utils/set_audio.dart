import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/audio_player/utils/get_audio_meta.dart';

import '../data/audio_repository.dart';
import 'list_to_source.dart';

Future<void> setAudioAndPlaylist(AudioPlayer audioPlayer, String audioId,
    String? playlistId, int audioSeq) async {
  final metadata = getAudioMeta(audioPlayer.sequenceState);
  if (!(metadata?.playlistId == playlistId && metadata?.id == audioId)) {
    if ((metadata?.playlistId ?? '') == playlistId) {
      await audioPlayer.seek(Duration.zero, index: audioSeq);
      return;
    }
    AudioSource source;
    if (metadata?.playlistId != null) {
      setAudio(audioPlayer, audioSeq);
    } else {
      final playlists = await NetworkAudioRepository().getAllPlaylists();
      source = listToSource(playlists!);
      await audioPlayer.setAudioSource(source, initialIndex: audioSeq);
      // source = (await NetworkAudioRepository().getPlaylistById(playlistId))
      //     .networkPlaylist;
    }
    audioPlayer.play();
    return;
  }
  return;
}

Future<void> setAudio(AudioPlayer audioPlayer, int index) async {
  await audioPlayer.seek(Duration.zero, index: index);
}
