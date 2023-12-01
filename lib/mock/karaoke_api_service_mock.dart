import 'package:dio/dio.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

final _songModel = SongModel(
  songId: 1,
  artist: 'Ed Sheeran',
  duration: 123,
  filename: 'filename',
  title: 'Thinking Out Loud',
  imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
  lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
  path: '',
  plays: 3,
  searchString: 'searchString',
);

class KaraokeApiServiceMock extends KaraokeApiService {
  KaraokeApiServiceMock() : super(configuration: const KaraokeAPIConfiguration(baseUrl: 'localhost'));

  @override
  Future<void> volumeUp() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> reorderQueue(int queueSongId, int newIndex) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<List<RepositoryPathModel>> addPath(RepositoryPathModel path) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return [];
  }

  @override
  Future<void> addSinger(String name, MultipartFile? image) async {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> addToQueue(int songId, String singerName, {int? keyChange}) {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> editSinger(SingerModel singer, MultipartFile? image) {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<NowPlayingSongModel?> getNowPlayingSong() {
    return Future<NowPlayingSongModel?>.delayed(const Duration(milliseconds: 50), () {
      return NowPlayingSongModel(
        position: 30,
        singer: 'Singer',
        songId: 1,
        song: _songModel,
        isPlaying: true,
      );
    });
  }

  @override
  Future<List<RepositoryPathModel>> getPaths() async {
    return [];
  }

  @override
  Future<PlaylistModel> getPlaylist(int id) async {
    return PlaylistModel(
      imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
      description: 'description',
      name: 'playlist',
      id: 1,
      songs: [
        SongModel(
          songId: 1,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 2,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
        SongModel(
          songId: 3,
          artist: 'Ed Sheeran',
          duration: 123,
          filename: 'filename',
          title: 'Thinking Out Loud',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
          lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
          path: '',
          plays: 3,
          searchString: 'searchString',
        ),
      ],
    );
  }

  @override
  Future<List<SimplePlaylistModel>> getPlaylists() async {
    return [
      const SimplePlaylistModel(
        id: 1,
        name: 'playlist',
        imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/1200x1200bf-60.jpg',
      ),
      const SimplePlaylistModel(
        id: 1,
        name: 'playlist',
      ),
      const SimplePlaylistModel(
        id: 1,
        name: 'playlist',
      )
    ];
  }

  @override
  Future<List<SongQueueItem>> getQueue() async {
    return [];
  }

  @override
  Future<List<SingerModel>> getSingers() async {
    return [
      const SingerModel(id: 1, name: 'Felipe'),
      const SingerModel(id: 2, name: 'Kami'),
      const SingerModel(id: 3, name: 'Gu'),
      const SingerModel(id: 4, name: 'Danilo'),
    ];
  }

  @override
  Future<bool> health() async {
    return true;
  }

  @override
  Future<void> pause() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> play() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> removeFromQueue(int requestId) {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<SongSearchResponse> search(String? title, String? artist, int page, int pageCount) async {
    return SongSearchResponse(page: 0, perPage: 1, total: 1, totalPages: 1, data: [_songModel]);
  }

  @override
  Future<SongSearchResponse> searchArtist(String? artist, int page, int pageCount) async {
    return SongSearchResponse(page: 0, perPage: 1, total: 1, totalPages: 1, data: [_songModel]);
  }

  @override
  Future<SongModel> sendYoutubeSong(YoutubeSongDto youtubeSongDto) {
    return Future<SongModel>.delayed(const Duration(milliseconds: 50), () {
      return _songModel;
    });
  }

  @override
  Future<void> setDownloadsPath(String path) {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<List<RepositoryPathModel>> setPaths(List<RepositoryPathModel> paths) {
    return Future<List<RepositoryPathModel>>.delayed(const Duration(milliseconds: 50), () {
      return [];
    });
  }

  @override
  Future<void> skip() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> stop() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> updatePlaylists() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> volumeDown() {
    return Future<void>.delayed(const Duration(milliseconds: 50));
  }
}
