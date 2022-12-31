// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AudioId {
  final String id;
  final String playlistId;
  AudioId({
    required this.id,
    required this.playlistId,
  });

  AudioId copyWith({
    String? id,
    String? playlistId,
  }) {
    return AudioId(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playlistId': playlistId,
    };
  }

  factory AudioId.fromMap(Map<String, dynamic> map) {
    return AudioId(
      id: map['id'] as String,
      playlistId: map['playlistId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudioId.fromJson(String source) =>
      AudioId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AudioId(id: $id, playlistId: $playlistId)';

  @override
  bool operator ==(covariant AudioId other) {
    if (identical(this, other)) return true;

    return other.id == id && other.playlistId == playlistId;
  }

  @override
  int get hashCode => id.hashCode ^ playlistId.hashCode;
}
