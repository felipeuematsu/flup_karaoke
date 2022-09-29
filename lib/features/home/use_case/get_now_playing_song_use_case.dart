import 'dart:html';

import 'package:dio/dio.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/util/abstract_use_case.dart';

class GetNowPlayingSongUseCase extends AbstractUseCase<void, NowPlayingSongModel?> {
  const GetNowPlayingSongUseCase(this.service);

  final KaraokeApiService service;

  @override
  Future<NowPlayingSongModel?> execute(void params) async {
    try {
      final response = await service.getNowPlayingSong();
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.notFound) {
        return null;
      }
      rethrow;
    }
  }
}
