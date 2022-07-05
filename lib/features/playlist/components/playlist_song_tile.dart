import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/models/song_model.dart';

class PlaylistSongTile extends StatelessWidget {
  PlaylistSongTile({Key? key, required this.song}) : super(key: key);

  static const height = 64.0;

  final SongModel song;

  late final duration = Duration(milliseconds: song.duration ?? 0);

  VoidCallback? get onTap => () {};

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      visualDensity: VisualDensity.compact,
      title: Text('${song.title}', overflow: TextOverflow.ellipsis, maxLines: 1),
      dense: true,
      isThreeLine: true,
      trailing: IconButton(onPressed: onTap, icon: Icon(Icons.play_arrow)),
      tileColor: Colors.grey[200],
      subtitle: Text('${song.artist}\n${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} - ${song.played ?? 0}${AppStrings.timesPlayed.tr}'),
    );
  }
}
