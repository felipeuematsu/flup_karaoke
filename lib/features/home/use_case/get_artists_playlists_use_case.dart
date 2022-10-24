import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/util/abstract_use_case.dart';

class GetArtistsPlaylistsUseCase extends AbstractUseCase<void, List<SimplePlaylistModel>> {
  const GetArtistsPlaylistsUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<List<SimplePlaylistModel>> execute(void params) async {
    await Future.delayed(const Duration(seconds: 5));
    return Future.value([
      SimplePlaylistModel(id: 6, name: 'Ed Sheeran'),
      SimplePlaylistModel(id: 7, name: 'Taylor Swift'),
      SimplePlaylistModel(id: 8, name: 'blackbear'),
      SimplePlaylistModel(id: 9, name: 'Lauv'),
    ]);

    // return service.getPlaylistsIds();
  }
}
