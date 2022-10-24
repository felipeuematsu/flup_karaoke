import 'dart:async';

import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/home/use_case/get_now_playing_song_use_case.dart';

class NowPlayingSongController {
  NowPlayingSongController(this.getNowPlayingSongUseCase);
  final GetNowPlayingSongUseCase getNowPlayingSongUseCase;

  late final Timer _refreshTimer;

  final _nowPlayingSongStream = StreamController<NowPlayingSongModel?>.broadcast();
  final _remainingTimePercentage = StreamController<double?>.broadcast();

  Stream<NowPlayingSongModel?> get nowPlayingSongStream => _nowPlayingSongStream.stream;
  Stream<double?> get remainingTimePercentage => _remainingTimePercentage.stream;

  double? updateRemainingTimePercentage(NowPlayingSongModel? nowPlayingSong) {
    final position = nowPlayingSong?.position;
    final duration = nowPlayingSong?.song?.duration;
    return position == null || duration == null ? null : position / duration;
  }
  Future<void> _refresh() async {
    final nowPlayingSongModel = await getNowPlayingSongUseCase.execute(null);
    _nowPlayingSongStream.add(nowPlayingSongModel);
    final percentage = updateRemainingTimePercentage(nowPlayingSongModel);
    if (percentage != null) {
      _remainingTimePercentage.add(percentage);
    }
  }

  void init() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) => _refresh());
  }

  void dispose() {
    _refreshTimer.cancel();
    _nowPlayingSongStream.close();
  }
}
