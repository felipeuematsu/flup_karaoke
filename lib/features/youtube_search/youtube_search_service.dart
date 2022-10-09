import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeSearchService {
  YoutubeSearchService(this.yt);

  final YoutubeExplode yt;

  final searchResultsController = StreamController<List<Video>>.broadcast();

  List<Video> results = [];
  VideoSearchList? last;

  Future<void> search(String query) async {
    try {
      final VideoSearchList searchResults = await yt.search.search(query);
      searchResultsController.add(results = last = searchResults);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> searchMore() async {
    final searchList = last;
    if (searchList != null) {
      final searchResults = await searchList.nextPage();
      if (searchResults != null) {
        searchResultsController.add(results..addAll(last = searchResults));
      }
    }
  }

  Future<StreamManifest> getManifest(Video video) async {
    final videoData = await yt.videos.streamsClient.getManifest(video.id);
    return videoData;
  }

  void dispose() {
    searchResultsController.close();
    yt.close();
  }
}
