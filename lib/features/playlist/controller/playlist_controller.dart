import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistController {

  final KaraokeApiService service = GetIt.I();

  Future<List<SimplePlaylistModel>> getPlaylists() {
    return service.getPlaylists();
  }

  Future<PlaylistModel> getPlaylist(int id) {
    return service.getPlaylist(id);
  }
}