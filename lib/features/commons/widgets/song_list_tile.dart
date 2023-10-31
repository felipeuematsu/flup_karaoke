import 'package:flup_karaoke/extensions/duration.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({super.key, required this.song});

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    final imageUrl = song.imageUrl;

    final duration = Duration(seconds: song.duration ?? 0);
    final subtitle = '${song.artist ?? '--'} - ${duration.toMinutesSeconds()}';
    return SizedBox(
      height: 64,
      child: ListTile(
        title: Text(song.title ?? '--'),
        subtitle: Text(subtitle),
        leading: Container(
          height: 64,
          width: 64,
          padding: const EdgeInsets.all(8.0),
          child: imageUrl != null ? Image.network(imageUrl) : const Icon(Icons.music_note),
        ),
      ),
    );
  }
}
