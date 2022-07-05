import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/models/song_model.dart';
import 'package:karaoke_request_client/util/abstract_use_case.dart';

class GetPlaylistSongsUseCase extends AbstractUseCase<int, List<SongModel>> {
  const GetPlaylistSongsUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<List<SongModel>> execute(int params) async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => List.generate(50, (index) => index)
          .map((e) => SongModel(
                title: 'Song $e',
                artist: 'Artist $e',
                duration: 183000,
                played: 3,
                songId: e,
              ))
          .toList(),
    );
  }
}
