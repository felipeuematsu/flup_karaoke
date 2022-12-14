import 'dart:async';

import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongSearchService {
  SongSearchService(this._service, this.validation, {this.pageCount = 10}) {
    titleStreamController.stream.listen((value) => title = value);
    artistStreamController.stream.listen((value) => artist = value);
  }

  final KaraokeApiService _service;
  final bool Function() validation;
  final int pageCount;

  final StreamController<String> titleStreamController = StreamController<String>.broadcast();
  final StreamController<String> artistStreamController = StreamController<String>.broadcast();

  String title = '', artist = '';
  String? lastSearchTitle = '', lastSearchArtist = '';
  int? page;

  List<SongModel> _songs = [];

  final StreamController<List<SongModel>?> _songStreamController = StreamController<List<SongModel>?>.broadcast();

  Stream<List<SongModel>?> get songStream => _songStreamController.stream;

  Future<void> search() async {
    try {
      if (validation() == false) return;
      if ((title.length < 3) && (artist.length < 3)) {
        _songStreamController.add(null);
      }

      final filteredTitle = lastSearchTitle = title;
      final filteredArtist = lastSearchArtist = artist;
      await _service.search(filteredTitle, filteredArtist, 1, pageCount).then((value) {
        _songs = value.data ?? [];
        _songStreamController.add(_songs);
        final totalPages = value.totalPages ?? 0;
        final currentPage = value.page ?? 0;
        page = totalPages == currentPage ? null : currentPage + 1;
      });
    } catch (e) {
      _songStreamController.add(null);
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

  String? Function(String?) artistValidator(BuildContext context) => (String? value) {
        if (title.length < 3 && (value == null || value.length < 3)) {
          return AppStrings.searchTooShort.tr(context);
        }
        return null;
      };

  String? Function(String?) titleValidator(BuildContext context) => (String? value) {
        if (artist.length < 3 && (value == null || value.length < 3)) {
          return AppStrings.searchTooShort.tr(context);
        }
        return null;
      };
}
