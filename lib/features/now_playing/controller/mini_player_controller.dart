import 'package:flutter/widgets.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class NowPlayingController {
  final nowPlayingSong = ValueNotifier<NowPlayingSongModel?>(null);
  final currentVolume = ValueNotifier<int?>(null);
}
