import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/widgets/add_to_queue_dialog/add_to_queue_dialog.dart';
import 'package:flup_karaoke/features/widgets/open_store_widget.dart';
import 'package:flup_karaoke/features/youtube_search/youtube_search_dialog.dart';
import 'package:flup_karaoke/features/youtube_search/youtube_search_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeSearchView extends StatefulWidget {
  const YoutubeSearchView({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  State<YoutubeSearchView> createState() => _YoutubeSearchViewState();
}

class _YoutubeSearchViewState extends State<YoutubeSearchView> {
  final YoutubeSearchService _searchService = YoutubeSearchService(YoutubeExplode());
  final _scrollController = ScrollController();

  final _searchMoreRefreshKey = GlobalKey<RefreshIndicatorState>();
  final _searchRefreshKey = GlobalKey<RefreshIndicatorState>();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      _searchMoreRefreshKey.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.youtubeSearchTitle.tr)),
      body: RefreshIndicator(
        onRefresh: () => _searchService.search(searchController.text),
        key: _searchRefreshKey,
        child: Center(
          child: kIsWeb
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.ohNo.tr, style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 12),
                    Text(AppStrings.youtubeSearchNotSupportedOnWeb.tr, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    const OpenStoreWidget(),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (_) => _searchRefreshKey.currentState?.show(),
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: AppStrings.youtubeSearchHint.tr,
                          suffixIcon: IconButton(onPressed: () => _searchRefreshKey.currentState?.show(), icon: const Icon(Icons.search)),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: _searchService.searchResultsController.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) return const SizedBox.shrink();
                            if (data.isEmpty) return Text(AppStrings.noResults.tr);
                            return RefreshIndicator(
                              key: _searchMoreRefreshKey,
                              onRefresh: () => _searchService.searchMore(),
                              child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Image.network(data[index].thumbnails.mediumResUrl),
                                    title: Text(data[index].title),
                                    subtitle: Text(data[index].author),
                                    onTap: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => YoutubeSearchDialog(
                                        service: widget.service,
                                        video: data[index],
                                        futureManifest: _searchService.getManifest(data[index]),
                                      ),
                                    ).then((value) {
                                      if (value is SongModel) {
                                        return showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) => AddToQueueDialog(service: widget.service, song: value),
                                        );
                                      }
                                    }),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchService.dispose();
    _scrollController.dispose();
  }
}
