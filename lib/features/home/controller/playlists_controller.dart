import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';

class PlaylistsController {
  PlaylistsController(this.getServerPlaylistsUseCase, this.getDetailedPlaylistUseCase);

  final GetServerPlaylistsUseCase getServerPlaylistsUseCase;
  final GetDetailedPlaylistUseCase getDetailedPlaylistUseCase;

  final _playlists = StreamController<List<SimplePlaylistModel>?>.broadcast();

  Stream<List<SimplePlaylistModel>?> get playlistsStream => _playlists.stream;

  VoidCallback onPlaylistTapped(BuildContext context, {required int playlistId}) => () {
    // TODO: implement onPlaylistTapped with new Router
  };

  void init() {
    _playlists.add(null);
    getServerPlaylistsUseCase.execute(null).then((value) => _playlists.add(value));
  }

  void dispose() {
    _playlists.close();
  }

}
