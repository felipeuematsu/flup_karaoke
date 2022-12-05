import 'dart:async';

import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/features/home/use_case/get_complete_playlist.dart';
import 'package:flup_karaoke/features/home/use_case/get_playlists_use_case.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

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
    _playlists.add(null);
    final playlists = await getServerPlaylistsUseCase.execute(null);
    _playlists.add(playlists);
  }

  void dispose() {
    _playlists.close();
  }
}
