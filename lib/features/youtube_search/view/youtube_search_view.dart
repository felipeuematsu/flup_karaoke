import 'package:auto_route/annotations.dart';
import 'package:flup_karaoke/features/playlist/view/components/add_to_queue_bottom_sheet.dart';
import 'package:flup_karaoke/features/search/view/components/responses/awaiting_query_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_items_found_widget.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_more_items_widget.dart';
import 'package:flup_karaoke/features/youtube_search/controller/youtube_search_controller.dart';
import 'package:flup_karaoke/features/youtube_search/view/components/youtube_search_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late final controller = YoutubeSearchController();

  final isSearching = ValueNotifier(false);

  final pagingController = PagingController<int, VideoDto>(firstPageKey: 0, invisibleItemsThreshold: 2);

  final searchController = TextEditingController();
  final focusNode = FocusNode();

  final scrollController = ScrollController();

  int lastScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(_searchMore);
  }

  Future<void> _searchMore(int pageKey) async {
    final res = pagingController.itemList?.isEmpty ?? true ? await controller.search(searchController.text) : await controller.searchMore();
    if (res.content?.isEmpty ?? false) {
      pagingController.appendLastPage(res.content ?? []);
    } else {
      pagingController.appendPage(res.content ?? [], pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            if (lastScrollPosition != 0) {
              scrollController.animateTo(lastScrollPosition.toDouble(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              return;
            }
            lastScrollPosition = scrollController.offset.toInt();
            scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          child: FittedBox(child: Text(FlupS.of(context).youtubeSearch)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoScrollbar(

          thickness: 5,
          radiusWhileDragging: const Radius.circular(5),
          controller: scrollController,
          child: SingleChildScrollView(

            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                focusNode: focusNode,
                onSubmitted: (value) {
                  pagingController.refresh();
                  _searchMore(0);
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: FlupS.of(context).search,
                  suffixIcon: IconButton(
                    onPressed: () {
                      focusNode.unfocus();
                      pagingController.refresh();
                      _searchMore(0);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: pagingController,
                builder: (context, value, child) {
                  if (value.itemList?.isEmpty ?? true) return const Center(child: AwaitingQueryWidget());
                  return PagedListView<int, VideoDto>(
                    physics: const NeverScrollableScrollPhysics(),
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
                              futureManifest: controller.getManifest(item.id ?? ''),
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
      ),
    );
  }
}
