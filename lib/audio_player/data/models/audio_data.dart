// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AudioData {
  String filename;
  String title;
  AudioData({
    required this.filename,
    required this.title,
  });

  AudioData copyWith({
    String? filename,
    String? title,
  }) {
    return AudioData(
      filename: filename ?? this.filename,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filename': filename,
      'title': title,
    };
  }

  factory AudioData.fromMap(Map<String, dynamic> map) {
    return AudioData(
      filename: map['filename'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudioData.fromJson(String source) =>
      AudioData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AudioData(filename: $filename, title: $title)';

  @override
  bool operator ==(covariant AudioData other) {
    if (identical(this, other)) return true;

    return other.filename == filename && other.title == title;
  }

  @override
  int get hashCode => filename.hashCode ^ title.hashCode;
}
