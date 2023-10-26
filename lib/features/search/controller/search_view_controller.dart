import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SearchViewController {
  final isSearching = ValueNotifier(false);

  final TextEditingController artistController = TextEditingController();
  final TextEditingController songTitleController = TextEditingController();

  final pagingController = PagingController<int, SongModel>(firstPageKey: 0, invisibleItemsThreshold: 2);



  void dispose() {
    artistController.dispose();
    songTitleController.dispose();
    pagingController.dispose();
  }
}
