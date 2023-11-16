import 'package:flup_karaoke/extensions/duration.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({super.key, required this.song, this.onTap});

  final SongModel song;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = song.imageUrl;

    final duration = Duration(seconds: song.duration ?? 0);
    final subtitle = '${song.artist ?? '--'} - ${duration.toMinutesSeconds()}';
    return SizedBox(
      height: 64,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        horizontalTitleGap: 8,
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        title: Text(song.title ?? '--'),
        subtitle: Text(subtitle),
        leading: SizedBox.square(dimension: 64, child: imageUrl != null ? Image.network(imageUrl) : const Icon(Icons.music_note)),
      ),
    );
  }
}
