import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_ga/audio_player/data/models/playlist.dart';

import '../../audio/view/audio_item.dart';
import '../../audio_player/utils/get_audiolist_seq.dart';

class PlaylistPage extends ConsumerWidget {
  final List<Playlist> playlists;
  final int id;
  const PlaylistPage({super.key, required this.playlists, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: playlists[id].audioList.length,
      itemBuilder: (context, i) {
        return AudioItem(
          audioData: playlists[id].audioList[i],
          audioSeq: getAudioListSeq(playlists, id, i),
          seqInPlaylist: i,
          playlist: playlists[id],
        );
      },
    );
  }
}
