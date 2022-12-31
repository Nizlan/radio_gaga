import 'package:flutter/material.dart';
import 'package:radio_ga/audio_player/view/mediadata_widget.dart';

class BigMetadata extends MediaDataWidget {
  const BigMetadata(
      {super.key, required super.title, required super.playlistTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6)),
          child: Text(
            playlistTitle,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
