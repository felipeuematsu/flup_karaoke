import 'dart:async';

import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';

class SongSearchService {
  SongSearchService(this._service) {
    titleStreamController.stream.listen((value) => title = value);
    artistStreamController.stream.listen((value) => artist = value);
  }

  final StreamController<String> titleStreamController = StreamController<String>.broadcast();
  final StreamController<String> artistStreamController = StreamController<String>.broadcast();

  String title = '', artist = '';

  int page = 1;

  List<SongModel> _songs = [];

  final StreamController<List<SongModel>?> _songStreamController = StreamController<List<SongModel>?>.broadcast();

  Stream<List<SongModel>?> get songStream => _songStreamController.stream;

  final KaraokeApiService _service;

  String? search({pageCount = 10}) {
    if ((title.length < 3) && (artist.length < 3)) {
      _songStreamController.add(null);
      return AppStrings.searchTooShort.tr;
    }

    final filteredTitle = title.length > 3 ? title : null;
    final filteredArtist = artist.length > 3 ? artist : null;

    _service.search(filteredTitle, filteredArtist, page, pageCount).then((value) {
      if (page == 1) {
        _songs = value.data ?? [];
      } else {
        _songs.addAll(value.data ?? []);
      }
      if ((value.totalPages ?? 0) > page) {
        page++;
      }
      _songStreamController.add(_songs);
    });
    return null;
  }
}
