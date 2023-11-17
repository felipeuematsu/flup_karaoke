import 'dart:async';

import 'package:karaoke_request_api/karaoke_request_api.dart';

class YoutubeSearchController {
  final KaraokeApiService service;

  YoutubeSearchController(this.service);

  String? uuid;

  Future<SearchQueryResponse> search(String query) async {
    return service.youtubeSearch(query, null);
  }

  Future<SearchQueryResponse> searchMore(String uuid) async {
    return service.youtubeSearch(null, uuid);
  }

  Future<VideoManifestResponse> getManifest(String videoId) async {
    return service.youtubeManifest(videoId);
  }
}
