import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/home/components/playlists_scroll_item.dart';
import 'package:karaoke_request_client/features/home/components/playlists_scroll_loading_item.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';
import 'package:karaoke_request_client/features/models/now_playing_song_model.dart';
import 'package:karaoke_request_client/features/models/simple_playlist_model.dart';
import 'package:karaoke_request_client/features/playlist/playlist_view.dart';

class HomeController extends GetxController {
  HomeController(this.getPlaylistsUseCase, this.getNowPlayingSongUseCase, this.getPlaylistSongsUseCase);

  final GetPlaylistsUseCase getPlaylistsUseCase;
  final GetPlaylistSongsUseCase getPlaylistSongsUseCase;
  final GetNowPlayingSongUseCase getNowPlayingSongUseCase;

  final _playlists = RxList<SimplePlaylistModel>();
  final _nowPlayingSong = Rxn<NowPlayingSongModel>();
  final _remainingTimePercentage = Rx(0.0);
  final _isLoading = RxBool(false);

  late final Timer refreshTimer, remainingTimeTimer;

  get isLoading => _isLoading.value;

  get playlistsWidgets {
    if (isLoading) {
      return const [
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
      ];
    }
    return _playlists
        .map((playlist) => PlaylistScrollItem(
            name: playlist.title ?? '',
            onPressed: () {
              Get.to(() {
                return PlaylistView(playlistModel: playlist, futureSongs: getPlaylistSongsUseCase.execute(playlist.id ?? 0));
              });
            }))
        .toList();
  }

  NowPlayingSongModel? get nowPlayingSong => _nowPlayingSong.value;

  double get remainingTimePercentage => _remainingTimePercentage.value;

  double get updateRemainingTimePercentage {
    final time = nowPlayingSong?.startTime;
    final duration = nowPlayingSong?.song?.duration;
    if (time == null || duration == null) {
      return 0;
    }
    final now = DateTime.now();
    final diff = now.difference(time);
    final percent = diff.inMilliseconds / duration;
    return percent;
  }

  @override
  Future<void> onInit() async {
    _isLoading.value = true;
    _playlists.value = await getPlaylistsUseCase.execute(null);

    refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getNowPlayingSongUseCase.execute(null).then((nowPlayingSong) {
        _nowPlayingSong.value = nowPlayingSong;
      });
    });

    remainingTimeTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _remainingTimePercentage.value = updateRemainingTimePercentage;
    });
    _isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    refreshTimer.cancel();
    remainingTimeTimer.cancel();
    super.onClose();
  }
}
