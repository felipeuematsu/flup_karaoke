import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/app_imports.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';
import 'package:karaoke_request_client/router/app_router.dart';

class PlaylistsController {
  PlaylistsController(this.getServerPlaylistsUseCase, this.getDetailedPlaylistUseCase);

  final GetServerPlaylistsUseCase getServerPlaylistsUseCase;
  final GetDetailedPlaylistUseCase getDetailedPlaylistUseCase;

  final _playlists = StreamController<List<SimplePlaylistModel>?>.broadcast();

  Stream<List<SimplePlaylistModel>?> get playlistsStream => _playlists.stream;

  VoidCallback onPlaylistTapped(BuildContext context, {required int playlistId}) => () {
    context.pushRoute(PlaylistViewRoute(id: playlistId, service: GetIt.I.get(), getDetailedPlaylistUseCase: getDetailedPlaylistUseCase));
  };

  void init() {
    _playlists.add(null);
  }

  Future<void> execute() async {
    final playlists = await getServerPlaylistsUseCase.execute(null);
    _playlists.add(playlists);
  }

  void dispose() {
    _playlists.close();
  }

}
