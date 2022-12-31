import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/audio_player/data/audio_repository.dart';
import 'package:radio_ga/audio_player/providers.dart';
import 'package:radio_ga/audio_player/utils/get_audio_meta.dart';

import '../../audio_player/data/models/playlist.dart';
import '../../audio_player/view/controls.dart';
import '../../audio_player/view/progress_audio_bar.dart';
import 'playlist_item.dart';

class PlaylistsPage extends ConsumerWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<List<Playlist>?>(
          future: NetworkAudioRepository().getAllPlaylists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final playlists = snapshot.data;
              if (playlists == null) {
                return const SizedBox();
              }
              return Column(
                children: [
                  StreamBuilder<SequenceState?>(
                      stream: player.sequenceStateStream,
                      builder: (context, snapshot) {
                        final hasData = snapshot.data != null;
                        return AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 400),
                          height: hasData
                              ? MediaQuery.of(context).size.height * 0.4
                              : 0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: hasData
                              ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          getAudioMeta(snapshot.data)?.title ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ProgressAudioBar(
                                            audioPlayer: player),
                                      ),
                                      Controls(audioPlayer: player, size: 50),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        );
                      }),
                  Expanded(
                      child: Swiper(
                    itemCount: playlists.length,
                    itemBuilder: (BuildContext context, int i) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: PlaylistItem(playlists: playlists, id: i));
                    },
                    viewportFraction: 0.68,
                    scale: 0.8,
                  )
                      // ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: playlists.length,
                      //   itemBuilder: (context, i) => SizedBox(
                      //       width: MediaQuery.of(context).size.width * 0.8,
                      //       child: PlaylistItem(playlist: playlists[i])),
                      // ),
                      ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
