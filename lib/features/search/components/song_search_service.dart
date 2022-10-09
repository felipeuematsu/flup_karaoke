import 'dart:async';

import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';

class SongSearchService {
  SongSearchService(this._service, {this.pageCount = 10}) {
    titleStreamController.stream.listen((value) => title = value);
    artistStreamController.stream.listen((value) => artist = value);
  }

  final StreamController<String> titleStreamController = StreamController<String>.broadcast();
  final StreamController<String> artistStreamController = StreamController<String>.broadcast();

  final int pageCount;
  String title = '', artist = '';
  String? lastSearchTitle = '', lastSearchArtist = '';
  int? page;

  List<SongModel> _songs = [];

  final StreamController<List<SongModel>?> _songStreamController = StreamController<List<SongModel>?>.broadcast();

  Stream<List<SongModel>?> get songStream => _songStreamController.stream;

  final KaraokeApiService _service;

  String? search() {
    try {
      if ((title.length < 3) && (artist.length < 3)) {
        _songStreamController.add(null);
        return AppStrings.searchTooShort.tr;
      }

      final filteredTitle = lastSearchTitle = title.length > 3 ? title : null;
      final filteredArtist = lastSearchArtist = artist.length > 3 ? artist : null;
      _service.search(filteredTitle, filteredArtist, 1, pageCount).then((value) {
        _songs = value.data ?? [];
        _songStreamController.add(_songs);
        final totalPages = value.totalPages ?? 0;
        final currentPage = value.page ?? 0;
        page = totalPages == currentPage ? null : currentPage + 1;
      });
      return null;
    } catch (e) {
      return AppStrings.searchError.tr;
    }
  }

  Future<void> searchMore() async {
    final nextPage = page;

    if (nextPage == null) {
      return;
    }

    _service.search(lastSearchTitle, lastSearchArtist, nextPage, pageCount).then((value) {
      _songs.addAll(value.data ?? []);
      _songStreamController.add(_songs);
      final totalPages = value.totalPages ?? 0;
      final currentPage = value.page ?? 0;
      page = totalPages == currentPage ? null : currentPage + 1;
    });
  }
}
