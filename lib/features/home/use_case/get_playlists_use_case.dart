import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/models/simple_playlist_model.dart';
import 'package:karaoke_request_client/util/abstract_use_case.dart';

class GetPlaylistsUseCase extends AbstractUseCase<void, List<SimplePlaylistModel>> {
  const GetPlaylistsUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<List<SimplePlaylistModel>> execute(void params) async {
    await Future.delayed(const Duration(seconds: 5));
    return Future.value([
      SimplePlaylistModel(id: 1, title: 'Playlist 1'  ),
      SimplePlaylistModel(id: 2, title: 'Playlist 2'  ),
      SimplePlaylistModel(id: 3, title: 'Playlist 3'  ),
      SimplePlaylistModel(id: 4, title: 'Playlist 4'  ),
    ]);

    // return service.getPlaylistsIds();
  }
}
