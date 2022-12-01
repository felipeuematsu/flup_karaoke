import 'package:flup_karaoke/util/abstract_use_case.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class GetServerPlaylistsUseCase extends AbstractUseCase<void, List<SimplePlaylistModel>> {
  const GetServerPlaylistsUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<List<SimplePlaylistModel>> execute(void params) async {
    return service.getPlaylists();
  }
}
