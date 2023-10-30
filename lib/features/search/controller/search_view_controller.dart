import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SearchViewController {
  final isSearching = ValueNotifier(false);

  final KaraokeApiService service = GetIt.I();

  final TextEditingController artistController = TextEditingController();
  final TextEditingController songTitleController = TextEditingController();

  late final pagingController = PagingController<int, SongModel>(firstPageKey: 0, invisibleItemsThreshold: 2)..addPageRequestListener(_fetchMore);

  String lastArtist = '';
  String lastSong = '';

  void onSubmit() {
    pagingController.refresh();
    _fetchMore(0);
    isSearching.value = true;
  }

  Future<SongSearchResponse> search(int page) async {
    lastArtist = artistController.text;
    lastSong = songTitleController.text;

    return service.search(lastSong, lastArtist, page, 20);
  }

  Future<void> _fetchMore(int pageKey) async {
    final response = await search(pageKey);
    if (pageKey == response.page) {
      pagingController.appendLastPage(response.data ?? []);
    } else {
      pagingController.appendPage(response.data ?? [], pageKey + 1);
    }
  }

  void dispose() {
    artistController.dispose();
    songTitleController.dispose();
    pagingController.dispose();
  }
}
