import 'package:karaoke_request_client/features/models/song_model.dart';

class CompletePlaylistModel {
  int? id;
  String? name;
  List<SongModel>? songs;

//<editor-fold desc="Data Methods">

  CompletePlaylistModel({
    this.id,
    this.name,
    this.songs,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || (other is CompletePlaylistModel && runtimeType == other.runtimeType && id == other.id && name == other.name && songs == other.songs);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ songs.hashCode;

  @override
  String toString() {
    return 'SimplePlaylistModel{ id: $id, name: $name, songs: $songs,}';
  }

  CompletePlaylistModel copyWith({
    int? id,
    String? name,
    List<SongModel>? songs,
  }) {
    return CompletePlaylistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'songs': songs,
    };
  }

  factory CompletePlaylistModel.fromMap(map) {
    return CompletePlaylistModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      songs: (map['songs'] as List).map((e) => SongModel.fromMap(e)).toList(),
    );
  }

//</editor-fold>
}
