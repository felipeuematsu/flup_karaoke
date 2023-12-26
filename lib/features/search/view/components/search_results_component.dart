import 'package:flup_karaoke/features/commons/widgets/song_list_tile.dart';
import 'package:flup_karaoke/features/playlist/view/components/add_to_queue_bottom_sheet.dart';
import 'package:flup_karaoke/features/search/controller/search_view_controller.dart';
import 'package:flup_karaoke/features/search/view/components/responses/awaiting_query_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_items_found_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_more_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchResultsComponent extends StatefulWidget {
  const SearchResultsComponent({super.key, required this.controller});

  final SearchViewController controller;

  @override
  State<SearchResultsComponent> createState() => _SearchResultsComponentState();
}

class _SearchResultsComponentState extends State<SearchResultsComponent> {
  SearchViewController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isSearching,
      builder: (context, value, child) {
        if (!value) return const Center(child: SingleChildScrollView(child: AwaitingQueryWidget()));

        return PagedListView<int, SongModel>.separated(
          pagingController: controller.pagingController,
          separatorBuilder: (context, index) => const Divider(),
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => SongListTile(
              song: item,
              onTap: () => showCupertinoModalBottomSheet(context: context, builder: (context) => AddToQueueBottomSheet(song: item)),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(child: NoItemsFoundWidget()),
            noMoreItemsIndicatorBuilder: (context) => const Center(child: NoMoreItemsWidget()),
          ),
        );
      },
    );
  }
}
