import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_scroll_item.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_scroll_loading_item.dart';
import 'package:karaoke_request_client/features/home/components/playlists/scroll_item_type.dart';
import 'package:karaoke_request_client/features/home/use_case/get_artists_playlists_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';
import 'package:karaoke_request_client/features/playlist/playlist_view.dart';

class HomeController extends GetxController {
  HomeController(this.getPlaylistsUseCase, this.getNowPlayingSongUseCase, this.getDetailedPlaylistUseCase, this.getArtistsPlaylistsUseCase);

  final GetPlaylistsUseCase getPlaylistsUseCase;
  final GetArtistsPlaylistsUseCase getArtistsPlaylistsUseCase;
  final GetDetailedPlaylistUseCase getDetailedPlaylistUseCase;
  final GetNowPlayingSongUseCase getNowPlayingSongUseCase;

  final _playlists = RxList<SimplePlaylistModel>();
  final _artists = RxList<SimplePlaylistModel>();
  final _nowPlayingSong = Rxn<NowPlayingSongModel>();
  final _remainingTimePercentage = Rx(0.0);
  final _artistsAreLoading = RxBool(false);
  final _playlistsAreLoading = RxBool(false);

  late final Timer _refreshTimer, _remainingTimeTimer;

  get playlistsAreLoading => _playlistsAreLoading.value;

  get artistsAreLoading => _artistsAreLoading.value;

  List<StatelessWidget> playlistsWidgets(ScrollItemType type) {
    if (playlistsAreLoading && type == ScrollItemType.playlist) {
      return const [
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
        PlaylistScrollLoadingItem(),
      ];
    }
    if (artistsAreLoading && type == ScrollItemType.artist) {
      return const [
        PlaylistScrollLoadingItem(scrollItemType: ScrollItemType.artist),
        PlaylistScrollLoadingItem(scrollItemType: ScrollItemType.artist),
        PlaylistScrollLoadingItem(scrollItemType: ScrollItemType.artist),
        PlaylistScrollLoadingItem(scrollItemType: ScrollItemType.artist),
        PlaylistScrollLoadingItem(scrollItemType: ScrollItemType.artist),
      ];
    }
    final list = type == ScrollItemType.playlist ? _playlists : _artists;
    return list
        .map((playlist) => PlaylistScrollItem(
            url: playlist.imageUrl,
            scrollItemType: type,
            name: playlist.name ?? '',
            onPressed: (context) => () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return PlaylistView(futurePlaylist: getDetailedPlaylistUseCase.execute(playlist.id ?? 0), service: Get.find());
            }))))
        .toList();
  }

  NowPlayingSongModel? get nowPlayingSong => _nowPlayingSong.value;

  double get remainingTimePercentage => _remainingTimePercentage.value;

  double get updateRemainingTimePercentage {
    final position = nowPlayingSong?.position;
    final duration = nowPlayingSong?.song?.duration;
    if (position == null || duration == null) {
      return 0;
    }
    return 1 - (position / duration);
  }

  @override
  Future<void> onInit() async {
    _playlistsAreLoading.value = true;
    getPlaylistsUseCase.execute(null).then((value) {
      _playlistsAreLoading.value = false;
      _playlists.value = value;
    });

    _artistsAreLoading.value = true;
    getArtistsPlaylistsUseCase.execute(null).then((value) {
      _artistsAreLoading.value = false;
      _artists.value = value;
    });

    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getNowPlayingSongUseCase.execute(null).then((nowPlayingSong) {
        _nowPlayingSong.value = nowPlayingSong;
      });
    });

    _remainingTimeTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _remainingTimePercentage.value = updateRemainingTimePercentage;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _refreshTimer.cancel();
    _remainingTimeTimer.cancel();
    super.onClose();
  }
}
