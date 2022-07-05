class SongModel {
  int? songId, duration, played;
  String? title, artist;

//<editor-fold desc="Data Methods">

  SongModel({
    this.songId,
    this.duration,
    this.played,
    this.title,
    this.artist,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongModel && runtimeType == other.runtimeType && songId == other.songId && duration == other.duration && played == other.played && title == other.title && artist == other.artist);

  @override
  int get hashCode => songId.hashCode ^ duration.hashCode ^ played.hashCode ^ title.hashCode ^ artist.hashCode;

  @override
  String toString() {
    return 'SongModel{ songId: $songId, duration: $duration, played: $played, title: $title, artist: $artist,}';
  }

  SongModel copyWith({
    int? songId,
    int? duration,
    int? played,
    String? title,
    String? artist,
  }) {
    return SongModel(
      songId: songId ?? this.songId,
      duration: duration ?? this.duration,
      played: played ?? this.played,
      title: title ?? this.title,
      artist: artist ?? this.artist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'duration': duration,
      'played': played,
      'title': title,
      'artist': artist,
    };
  }

  factory SongModel.fromMap(map) {
    return SongModel(
      songId: map['songId'] as int,
      duration: map['duration'] as int,
      played: map['played'] as int,
      title: map['title'] as String,
      artist: map['artist'] as String,
    );
  }

//</editor-fold>
}