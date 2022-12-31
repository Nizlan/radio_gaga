import 'package:flutter/material.dart';

abstract class MediaDataWidget extends StatelessWidget {
  final String title;
  final String playlistTitle;
  const MediaDataWidget(
      {super.key, required this.title, required this.playlistTitle});
}
