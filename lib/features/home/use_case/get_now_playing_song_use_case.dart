import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/models/now_playing_song_model.dart';
import 'package:karaoke_request_client/features/models/simple_playlist_model.dart';
import 'package:karaoke_request_client/features/models/song_model.dart';
import 'package:karaoke_request_client/util/abstract_use_case.dart';

class GetNowPlayingSongUseCase extends AbstractUseCase<void, NowPlayingSongModel> {
   GetNowPlayingSongUseCase(this.service);

  final KaraokeApiService service;

  final startTime = DateTime.now();
  @override
  Future<NowPlayingSongModel> execute(void params) async {
    await Future.delayed(const Duration(seconds: 1));
    return Future.value(
      NowPlayingSongModel(
        singer: 'Singer',
        startTime: startTime,
        song: SongModel(
          title: 'Song',
          artist: 'Artist',
          duration: 183000,
          played: 3,
          songId: 3,
        ),
      ),
    );

    // return service.getNowPlayingSong();
  }
}
