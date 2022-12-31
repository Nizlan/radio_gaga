import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/audio_player/providers.dart';

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
            margin: const EdgeInsets.only(
                bottom: _horPadding, left: _horPadding, right: _horPadding),
            decoration: BoxDecoration(
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
                      fontSize: 18,
                      color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.yellow[00],
                    ),
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
