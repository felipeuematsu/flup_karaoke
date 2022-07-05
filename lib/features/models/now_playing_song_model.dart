import 'package:karaoke_request_client/features/models/song_model.dart';

class NowPlayingSongModel {
  DateTime? startTime;
  SongModel? song;
  String? singer;

//<editor-fold desc="Data Methods">

  NowPlayingSongModel({
    this.startTime,
    this.song,
    this.singer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is NowPlayingSongModel && runtimeType == other.runtimeType && startTime == other.startTime && song == other.song && singer == other.singer);

  @override
  int get hashCode => startTime.hashCode ^ song.hashCode ^ singer.hashCode;

  @override
  String toString() {
    return 'NowPlayingSongModel{ startTime: $startTime, song: $song, singer: $singer,}';
  }

  NowPlayingSongModel copyWith({
    DateTime? startTime,
    SongModel? song,
    String? singer,
  }) {
    return NowPlayingSongModel(
      startTime: startTime ?? this.startTime,
      song: song ?? this.song,
      singer: singer ?? this.singer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'song': song,
      'singer': singer,
    };
  }

  factory NowPlayingSongModel.fromMap(map) {
    return NowPlayingSongModel(
      startTime: DateTime.tryParse(map['startTime'] as String? ?? ''),
      song: SongModel.fromMap(map['song']),
      singer: map['singer'] as String?,
    );
  }

//</editor-fold>
}
