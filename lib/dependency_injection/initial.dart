import 'package:flup_karaoke/features/home/controller/now_playing_song_controller.dart';
import 'package:flup_karaoke/features/home/controller/playlists_controller.dart';
import 'package:flup_karaoke/features/home/use_case/get_complete_playlist.dart';
import 'package:flup_karaoke/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:flup_karaoke/features/home/use_case/get_playlists_use_case.dart';
import 'package:get_it/get_it.dart';

GetIt get _ => GetIt.I;

T g<T extends Object>() => _.get();

void injectInitialDependencies() {
  _.registerFactory<GetServerPlaylistsUseCase>(() => GetServerPlaylistsUseCase(g()));
  _.registerFactory<GetDetailedPlaylistUseCase>(() => GetDetailedPlaylistUseCase(g()));
  _.registerFactory<PlaylistsController>(() => PlaylistsController(g(), g()));
  _.registerFactory<GetNowPlayingSongUseCase>(() => GetNowPlayingSongUseCase(g()));
  _.registerFactory<NowPlayingSongController>(() => NowPlayingSongController(g()));
}
