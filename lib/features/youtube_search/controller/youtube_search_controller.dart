import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class YoutubeSearchController {
  final KaraokeApiService service = GetIt.I();

  YoutubeSearchController();

  String? uuid;
  DateTime? uuidExpiration;

  Future<SearchQueryResponse> search(String query) async {
    if (uuid == null || uuidExpiration == null || (uuidExpiration?.isBefore(DateTime.now()) ?? true)) {
      return searchQuery(query);
    }
    return searchMore();
  }

  Future<SearchQueryResponse> searchQuery(String query) async {
    final response = await service.youtubeSearch(query, null);

    uuid = response.uuid;
    uuidExpiration = response.expiration;
    return response;
  }

  Future<SearchQueryResponse> searchMore() async {
    if (uuid == null || uuidExpiration == null || (uuidExpiration?.isBefore(DateTime.now()) ?? true)) {
      uuid = null;
      uuidExpiration = null;
      return const SearchQueryResponse(content: []);
    }
    return service.youtubeSearch(null, uuid);
  }

  Future<VideoManifestResponse> getManifest(String videoId) async {
    return service.youtubeManifest(videoId);
  }
}
