import 'package:flup_karaoke/features/app_strings.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.youtubeSearchTitle.tr)),
      body: Center(
        child: kIsWeb
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.ohNo.tr, style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 12),
                  const SizedBox(height: 12),
                  Text(AppStrings.youtubeSearchNotSupportedOnWeb.tr, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  if (Theme.of(context).platform == TargetPlatform.android) const OpenStoreWidget(),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: AppStrings.youtubeSearchHint.tr, suffixIcon: const Icon(Icons.search)),
                      onSubmitted: (value) => _searchService.search(value),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: _searchService.searchResultsController.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          if (data != null) {
                            if (data.isEmpty) {
                              return Text(AppStrings.noResults.tr);
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final video = data[index];
                                  return ListTile(
                                    leading: Image.network(video.thumbnails.mediumResUrl),
                                    title: Text(video.title),
                                    subtitle: Text(video.author),
                                    onTap: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => YoutubeSearchDialog(
                                        service: widget.service,
                                        video: video,
                                        futureManifest: _searchService.getManifest(video),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchService.dispose();
  }
}
