import 'package:flup_karaoke/features/home/controller/now_playing_song_controller.dart';
import 'package:flup_karaoke/features/home/controller/playlists_controller.dart';
import 'package:flup_karaoke/features/home/use_case/get_complete_playlist.dart';
import 'package:flup_karaoke/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:flup_karaoke/features/home/use_case/get_playlists_use_case.dart';
import 'package:get_it/get_it.dart';

GetIt get _ => GetIt.I;

T g<T extends Object>() => _.get();

void injectInitialDependencies() {
  if (!_.isRegistered<GetServerPlaylistsUseCase>()) _.registerFactory<GetServerPlaylistsUseCase>(() => GetServerPlaylistsUseCase(g()));
  if (!_.isRegistered<GetDetailedPlaylistUseCase>()) _.registerFactory<GetDetailedPlaylistUseCase>(() => GetDetailedPlaylistUseCase(g()));
  if (!_.isRegistered<PlaylistsController>()) _.registerFactory<PlaylistsController>(() => PlaylistsController(g(), g()));
  if (!_.isRegistered<GetNowPlayingSongUseCase>()) _.registerFactory<GetNowPlayingSongUseCase>(() => GetNowPlayingSongUseCase(g()));
  if (!_.isRegistered<NowPlayingSongController>()) _.registerFactory<NowPlayingSongController>(() => NowPlayingSongController(g()));
}
