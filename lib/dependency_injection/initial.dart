import 'package:get_it/get_it.dart';
import 'package:karaoke_request_client/features/home/controller/now_playing_song_controller.dart';
import 'package:karaoke_request_client/features/home/controller/playlists_controller.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';

GetIt get _ => GetIt.I;

T g<T extends Object>() => _.get();

void injectInitialDependencies() {
  _.registerFactory<GetServerPlaylistsUseCase>(() => GetServerPlaylistsUseCase(g()));
  _.registerFactory<GetDetailedPlaylistUseCase>(() => GetDetailedPlaylistUseCase(g()));
  _.registerFactory<PlaylistsController>(() => PlaylistsController(g(), g()));
  _.registerFactory<GetNowPlayingSongUseCase>(() => GetNowPlayingSongUseCase(g()));
  _.registerFactory<NowPlayingSongController>(() => NowPlayingSongController(g()));
}
