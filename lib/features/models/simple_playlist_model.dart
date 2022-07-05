class SimplePlaylistModel {
  int? id;
  String? title;

//<editor-fold desc="Data Methods">

  SimplePlaylistModel({
    this.id,
    this.title,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || (other is SimplePlaylistModel && runtimeType == other.runtimeType && id == other.id && title == other.title);

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'SimplePlaylistModel{ id: $id, title: $title,}';
  }

  SimplePlaylistModel copyWith({
    int? id,
    String? title,
  }) {
    return SimplePlaylistModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory SimplePlaylistModel.fromMap(map) {
    return SimplePlaylistModel(
      id: map['id'] as int?,
      title: map['title'] as String?,
    );
  }

//</editor-fold>
}
