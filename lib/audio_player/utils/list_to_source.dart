import 'package:just_audio/just_audio.dart';

import '../data/models/playlist.dart';
import '../data/utils/get_network_audio.dart';

ConcatenatingAudioSource listToSource(List<Playlist> playlists) {
  List<UriAudioSource> sources = [];
  for (var p in playlists) {
    sources = [
      ...sources,
      ...networkAudio(
          data: p.audioList,
          playlistId: p.id,
          album: p.album,
          playlistTitle: p.title)
    ];
  }
  return ConcatenatingAudioSource(children: sources);
}
