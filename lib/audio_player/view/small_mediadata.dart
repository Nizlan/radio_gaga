import 'package:flutter/material.dart';
import 'package:radio_ga/audio_player/view/mediadata_widget.dart';

class SmallMetadata extends MediaDataWidget {
  const SmallMetadata(
      {super.key, required super.title, required super.playlistTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
