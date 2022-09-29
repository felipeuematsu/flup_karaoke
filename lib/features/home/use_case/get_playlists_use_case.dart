import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/util/abstract_use_case.dart';

class GetPlaylistsUseCase extends AbstractUseCase<void, List<SimplePlaylistModel>> {
  const GetPlaylistsUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<List<SimplePlaylistModel>> execute(void params) async {
    return service.getPlaylists();
  }
}
