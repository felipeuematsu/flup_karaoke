import 'package:flup_karaoke/extensions/duration.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({super.key, required this.song, this.onTap, this.singer});

  final SongModel song;
  final SingerModel? singer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = song.imageUrl;

    final duration = Duration(seconds: song.duration ?? 0);
    var subtitle = '${song.artist ?? '--'} - ${duration.toMinutesSeconds()}';
    final singerName = singer?.name;
    if (singerName != null) {
      subtitle += '\n$singerName';
    }
    return SizedBox(
      height: 64,
      child: ListTile(
        horizontalTitleGap: 8,
        onTap: onTap,
        title: Text(song.title ?? '--'),
        subtitle: Text(subtitle),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl ?? '', height: 48, width: 48, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.music_note, size: 48)),
        ),
      ),
    );
  }
}
