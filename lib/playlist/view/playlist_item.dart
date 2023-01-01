import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/audio_player/providers.dart';
import 'package:radio_ga/audio_player/utils/get_audio_meta.dart';

import '../../audio_player/data/audio_repository.dart';
import '../../audio_player/data/models/playlist.dart';
import 'playlist_page.dart';

final borderRadius = BorderRadius.circular(8);

const double _horPadding = 10;

class PlaylistItem extends ConsumerWidget {
  final List<Playlist> playlists;
  final int id;

  const PlaylistItem({super.key, required this.playlists, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(audioPlayerProvider);
    return StreamBuilder<SequenceState?>(
        stream: player.sequenceStateStream,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(
                bottom: _horPadding, left: _horPadding, right: _horPadding),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.srcOver),
                fit: BoxFit.cover,
                image: NetworkImage(
                  NetworkAudioRepository()
                      .getImageOfPlaylist(playlists[id].album),
                ),
              ),
              border:
                  getAudioMeta(snapshot.data)?.playlistId == playlists[id].id
                      ? Border.all(color: Colors.yellow, width: 5)
                      : null,
              borderRadius: borderRadius,
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlists[id].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: PlaylistPage(
                      playlists: playlists,
                      id: id,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
