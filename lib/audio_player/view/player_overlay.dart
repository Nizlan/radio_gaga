// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../style.dart';
import '../data/models/extended_media_item.dart';
import '../providers.dart';
import 'audio_attrubutes.dart';
import 'controls.dart';
import 'progress_audio_bar.dart';
import 'small_mediadata.dart';

class PlayerView {
  final SequenceState? sequenceState;
  final bool isOpen;
  PlayerView({
    this.sequenceState,
    required this.isOpen,
  });
}

Stream<PlayerView> positionDataStream(
    AudioPlayer audioPlayer, StateController<bool> isOpen) {
  return Rx.combineLatest2(
    audioPlayer.sequenceStateStream,
    isOpen.stream,
    (sequenceState, isOpen) =>
        PlayerView(sequenceState: sequenceState, isOpen: isOpen),
  );
}

void setTrue(StateController<bool> isOpen) {
  isOpen.update((state) => true);
}

void showPlayerOverlay(BuildContext context, WidgetRef ref) {
  final overlay = Overlay.of(context);
  OverlayEntry entry = OverlayEntry(
    builder: (context) => playerOverlay(
      context,
      ref,
    ),
  );
  overlay!.insert(entry);
}

Widget playerOverlay(BuildContext context, WidgetRef ref) {
  final audioPlayer = ref.read(audioPlayerProvider);
  final isOpenState = ref.watch(isPlayerOpen.notifier);
  return StreamBuilder<PlayerView?>(
      stream: positionDataStream(audioPlayer, isOpenState),
      builder: (context, snapshot) {
        final playerSequence = snapshot.data?.sequenceState?.currentSource;
        final isOpen = snapshot.data?.isOpen;
        if (playerSequence != null && (isOpen ?? false)) {
          final metadata = audioPlayer.sequenceState?.currentSource?.tag
              as ExtendedMediaItem?;
          return Positioned(
              height: Style.playerHeight,
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed('/audioPlayer', arguments: {
                  'playlistId': metadata!.playlistId,
                  'audioId': metadata.id,
                  'audioSeq': metadata.audioSeq,
                  'vertical': true
                }).then((value) => setTrue(isOpenState)),
                child: Material(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: AudioAttributes(
                            audioPlayer: audioPlayer,
                            child: (title, playlistTitle) => SmallMetadata(
                                title: title, playlistTitle: playlistTitle),
                          ),
                        ),
                        ProgressAudioBar(
                          audioPlayer: audioPlayer,
                          isSmall: true,
                        ),
                        Controls(
                          size: 50,
                          audioPlayer: audioPlayer,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        }
        return const SizedBox();
      });
}
