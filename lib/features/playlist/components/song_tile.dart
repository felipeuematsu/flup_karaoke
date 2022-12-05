import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song, this.onTap, this.singerModel}) : super(key: key);

  static const height = 64.0;

  final SongModel song;
  final SingerModel? singerModel;

  final VoidCallback? onTap;

  String get bySinger => singerModel != null ? '- ${singerModel?.name}' : '';

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: song.duration ?? 0);
    final imageUrl = song.imageUrl;
    return ListTile(
      leading: imageUrl != null ? AspectRatio(aspectRatio: 1, child: Image.network(imageUrl, fit: BoxFit.fitHeight)) : const Icon(Icons.music_note),
      visualDensity: VisualDensity.compact,
      title: Text('${song.title} $bySinger', overflow: TextOverflow.ellipsis, maxLines: 1),
      dense: false,
      isThreeLine: true,
      trailing: IconButton(onPressed: onTap, icon: singerModel != null ? const Icon(Icons.playlist_remove_sharp) : const Icon(Icons.queue_music)),
      tileColor: Colors.grey[200],
      subtitle: Text('${song.artist}\n${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} - ${song.plays ?? 0}${AppStrings.timesPlayed.tr}'),
    );
  }
}
