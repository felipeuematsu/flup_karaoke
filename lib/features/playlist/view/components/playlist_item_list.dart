import 'package:flup_karaoke/features/commons/widgets/song_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistItemList extends StatelessWidget {
  const PlaylistItemList({super.key, required this.songs});

  final List<SongModel> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      itemCount: songs.length,
      itemBuilder: (context, index) => SongListTile(song: songs[index]),
    );
  }
}
