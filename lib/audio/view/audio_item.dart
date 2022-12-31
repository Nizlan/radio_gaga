// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:radio_ga/audio_player/data/models/playlist.dart';

import '../../audio_player/data/models/audio_data.dart';
import '../../audio_player/providers.dart';
import '../../audio_player/utils/get_audio_meta.dart';
import '../../audio_player/utils/set_audio.dart';
import '../data/audio_id.dart';

class AudioItem extends ConsumerWidget {
  final AudioData audioData;
  final int audioSeq;
  final Playlist playlist;
  const AudioItem(
      {super.key,
      required this.audioData,
      required this.audioSeq,
      required this.playlist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await setAudioAndPlaylist(
              audioPlayer, audioData.filename, playlist.id, audioSeq, true);
        },
        child: Row(
          children: [
            Container(
              width: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: SequenceStateWidget(
                audioId: audioData.filename,
                playlistId: playlist.id,
                audioSeq: audioSeq,
                audioPlayer: audioPlayer,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text(
                audioData.title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class SequenceStateWidget extends StatelessWidget {
  final String playlistId;
  final String audioId;
  final int audioSeq;
  final AudioPlayer audioPlayer;
  const SequenceStateWidget({
    super.key,
    required this.playlistId,
    required this.audioId,
    required this.audioSeq,
    required this.audioPlayer,
  });

  bool isCurrentLoading(AudioId? loadingAudio) {
    if (loadingAudio == null) return false;
    return loadingAudio.id == audioId && loadingAudio.playlistId == playlistId;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<SequenceState?> sequences =
        audioPlayer.sequenceStateStream.transform(
      StreamTransformer.fromHandlers(
          handleData: (data, sink) => sink.add(data)),
    );
    return StreamBuilder<SequenceState?>(
      stream: sequences,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final meta = getAudioMeta(state);
        final isCurrentPlaying =
            meta?.id == audioId && meta?.playlistId == playlistId;
        return isCurrentPlaying
            ? AudioStateWidget(
                audioPlayer: audioPlayer,
              )
            : Text((audioSeq + 1).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white));
      },
    );
  }
}

class AudioStateWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioStateWidget({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        return snapshot.data?.playing ?? true
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.yellow, size: 20)
            : const Icon(
                Icons.pause,
                color: Colors.yellow,
              );
      },
    );
  }
}
