import 'package:flup_karaoke/database/database.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class CurrentSingerController {
  CurrentSingerController() {
    _currentSinger = _database.currentSinger;
  }

  final _database = AppDB.get();

  SingerModel? _currentSinger;

  SingerModel? get currentSinger => _currentSinger;

  set currentSinger(SingerModel? value) => _database.setCurrentSinger(_currentSinger = value);
}
