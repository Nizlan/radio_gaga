import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_ga/constants.dart';

import 'local_data.dart';
import 'models/playlist.dart';
import 'dart:convert';

abstract class AudioRepository {
  Future<AudioSource> getAudioById(String playlistId, String id);

  Future<Playlist> getPlaylistById(String id);

  Future<List<Playlist>?> getAllPlaylists();
}

class LocalAudioRepository implements AudioRepository {
  @override
  Future<List<Playlist>> getAllPlaylists() async {
    return LocalData.playlists;
  }

  @override
  Future<AudioSource> getAudioById(String playlistId, String id) {
    return getPlaylistById(playlistId).then((playlist) => playlist
        .localPlaylist.children
        .firstWhere((e) => e is UriAudioSource ? e.tag.id == id : false));
  }

  @override
  Future<Playlist> getPlaylistById(String id) async {
    return LocalData.playlists.firstWhere((e) => e.id == id);
  }
}

class NetworkAudioRepository implements AudioRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: APIConst.baseUrl));

  @override
  Future<Playlist> getPlaylistById(String id) async {
    Response response = await dio.get('/audio/$id');
    final r = json.decode(response.data);
    return Playlist.fromMap(r);
  }

  @override
  Future<List<Playlist>?> getAllPlaylists() async {
    print('started');
    try {
      Response response = await dio.get('/audio/');
      List<Playlist> playlists = [];

      var p = json.decode(response.data);
      for (var el in p) {
        playlists.add(Playlist.fromMap(el));
      }
      return playlists;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<AudioSource> getAudioById(String playlistId, String id) {
    return getPlaylistById(playlistId).then((playlist) => playlist
        .networkPlaylist.children
        .firstWhere((e) => e is UriAudioSource ? e.tag.id == id : false));
  }
}
