import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song, this.onTap, this.singerModel}) : super(key: key);

  static const height = 64.0;

  final SongModel song;
  final SingerModel? singerModel;

  final VoidCallback? onTap;

  Duration get duration => Duration(seconds: song.duration ?? 0);

  String get prefix => singerModel != null ? '${song.artist} - ' : '';

  String get subtitle => singerModel == null ? '${song.artist}' : '${singerModel?.name}';

  String get songInfo => '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} - ${song.plays ?? 0}${AppStrings.timesPlayed.tr}';

  @override
  Widget build(BuildContext context) {
    final imageUrl = song.imageUrl;
    return ListTile(
      onTap: onTap,
      leading: imageUrl != null ? AspectRatio(aspectRatio: 1, child: Image.network(imageUrl, fit: BoxFit.fitHeight)) : const Icon(Icons.music_note),
      visualDensity: VisualDensity.compact,
      title: Text('$prefix${song.title}', overflow: TextOverflow.ellipsis, maxLines: 1),
      dense: false,
      isThreeLine: true,
      tileColor: Colors.grey[200],
      subtitle: RichText(
        maxLines: 2,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            TextSpan(text: '$subtitle\n'),
            TextSpan(text: '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} - ${AppStrings.timesPlayed.tr.replaceAll('{}', '${song.plays ?? 0}')}'),
          ],
        ),
      ),
    );
  }
}
