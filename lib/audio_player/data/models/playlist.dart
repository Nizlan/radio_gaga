// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:radio_ga/audio_player/data/models/audio_data.dart';

import '../utils/get_local_audio.dart';
import '../utils/get_network_audio.dart';

class Playlist {
  final String id;
  final String album;
  final String title;
  final String description;
  final List<AudioData> audioList;
  Playlist({
    required this.id,
    required this.album,
    required this.title,
    required this.description,
    required this.audioList,
  });

  ConcatenatingAudioSource get localPlaylist => ConcatenatingAudioSource(
        children: localAudio(
          data: audioList,
          album: album,
          playlistTitle: title,
          playlistId: id,
        ),
      );
  ConcatenatingAudioSource get networkPlaylist => ConcatenatingAudioSource(
        children: networkAudio(
          data: audioList,
          album: album,
          playlistTitle: title,
          playlistId: id,
        ),
      );

  Playlist copyWith({
    String? id,
    String? album,
    String? title,
    String? description,
    List<AudioData>? audioList,
  }) {
    return Playlist(
      id: id ?? this.id,
      album: album ?? this.album,
      title: title ?? this.title,
      description: description ?? this.description,
      audioList: audioList ?? this.audioList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'album': album,
      'title': title,
      'description': description,
      'audioList': audioList.map((x) => x.toMap()).toList(),
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] as String,
      album: map['album'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      audioList: List<AudioData>.from(
        (map['audioList'] as List<dynamic>).map<AudioData>(
          (x) => AudioData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Playlist(id: $id, album: $album, title: $title, description: $description, audioList: $audioList)';
  }

  @override
  bool operator ==(covariant Playlist other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.album == album &&
        other.title == title &&
        other.description == description &&
        listEquals(other.audioList, audioList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        album.hashCode ^
        title.hashCode ^
        description.hashCode ^
        audioList.hashCode;
  }
}
