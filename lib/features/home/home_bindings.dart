import 'package:get/get.dart';
import 'package:karaoke_request_client/features/home/home_controller.dart';
import 'package:karaoke_request_client/features/home/use_case/get_artists_playlists_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/home/use_case/get_now_playing_song_use_case.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetPlaylistsUseCase>(() => GetPlaylistsUseCase(Get.find()));
    Get.lazyPut<GetArtistsPlaylistsUseCase>(() => GetArtistsPlaylistsUseCase(Get.find()));
    Get.lazyPut<GetNowPlayingSongUseCase>(() => GetNowPlayingSongUseCase(Get.find()));
    Get.lazyPut<GetDetailedPlaylistUseCase>(() => GetDetailedPlaylistUseCase(Get.find()));


    Get.lazyPut<HomeController>(() => HomeController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
