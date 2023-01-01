import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_ga/audio_player/providers.dart';

import 'shuffle.dart';

class ShuffleWidget extends ConsumerWidget {
  const ShuffleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(audioPlayerProvider);
    return Container(
      alignment: Alignment.centerRight,
      width: 230,
      height: 50,
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: StreamBuilder<bool>(
          stream: player.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            final shuffle = snapshot.data;
            return shuffle != null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(
                              shuffle
                                  ? 'Случайный порядок'
                                  : 'Плейлисты по порядку',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            height: 25,
                            child: Image.asset(
                              'assets/icons/shuffle.png',
                              color: shuffle ? Colors.yellow : Colors.grey,
                              width: 10,
                            ),
                          ),
                        ]),
                  )
                : Container(
                    color: Colors.white,
                    height: 10,
                    width: 10,
                  );
          },
        ),
        onTap: () => Shuffle.set(ref),
      ),
    );
  }
}
