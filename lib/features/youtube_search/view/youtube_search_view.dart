import 'package:auto_route/annotations.dart';
import 'package:flup_karaoke/features/playlist/view/components/add_to_queue_bottom_sheet.dart';
import 'package:flup_karaoke/features/search/view/components/responses/awaiting_query_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_items_found_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_more_items_widget.dart';
import 'package:flup_karaoke/features/youtube_search/controller/youtube_search_controller.dart';
import 'package:flup_karaoke/features/youtube_search/view/components/youtube_search_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class YoutubeSearchView extends StatefulWidget {
  const YoutubeSearchView({Key? key}) : super(key: key);

  @override
  State<YoutubeSearchView> createState() => _YoutubeSearchViewState();
}

class _YoutubeSearchViewState extends State<YoutubeSearchView> {
  final service = GetIt.I<KaraokeApiService>();
  late final controller = YoutubeSearchController(service);

  final isSearching = ValueNotifier(false);

  final pagingController = PagingController<int, VideoDto>(firstPageKey: 0, invisibleItemsThreshold: 4);

  final _searchRefreshKey = GlobalKey<RefreshIndicatorState>();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(child: Text(FlupS.of(context).youtubeSearch))),
      body: RefreshIndicator(
        onRefresh: () async => service.youtubeSearch(searchController.text, controller.uuid),
        key: _searchRefreshKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            TextField(
              onSubmitted: (_) => _searchRefreshKey.currentState?.show(),
              controller: searchController,
              decoration: InputDecoration(
                hintText: FlupS.of(context).search,
                suffixIcon: IconButton(onPressed: () => _searchRefreshKey.currentState?.show(), icon: const Icon(Icons.search)),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isSearching,
              builder: (context, value, child) {
                if (!value) return const Center(child: AwaitingQueryWidget());
                return PagedListView<int, VideoDto>(
                  shrinkWrap: true,
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) => const Center(child: NoItemsFoundWidget()),
                    noMoreItemsIndicatorBuilder: (context) => const Center(child: NoMoreItemsWidget()),
                    itemBuilder: (context, item, index) {
                      final thumbnail = item.thumbnails?.mediumResUrl;
                      return ListTile(
                        leading: thumbnail == null ? null : Image.network(thumbnail),
                        title: Text(item.title ?? ''),
                        subtitle: Text(item.author ?? ''),
                        onTap: () => showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => YoutubeSearchDialog(
                            video: item,
                            futureManifest: service.youtubeManifest(item.id ?? ''),
                          ),
                        ).then((value) {
                          if (value is SongModel) {
                            return showCupertinoModalBottomSheet(
                              context: context,
                              builder: (_) => AddToQueueBottomSheet(song: value),
                            );
                          }
                        }),
                      );
                    },
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
