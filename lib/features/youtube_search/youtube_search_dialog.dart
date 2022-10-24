import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/features/app_strings.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeSearchDialog extends StatefulWidget {
  const YoutubeSearchDialog({Key? key, required this.service, required this.futureManifest, required this.video}) : super(key: key);

  final KaraokeApiService service;
  final Video video;
  final Future<StreamManifest> futureManifest;

  @override
  State<YoutubeSearchDialog> createState() => _YoutubeSearchDialogState();
}

class _YoutubeSearchDialogState extends State<YoutubeSearchDialog> {
  late final titleController = TextEditingController(text: video.title);
  final artistController = TextEditingController();

  Video get video => widget.video;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.addYoutubeSong.tr),
      content: FutureBuilder(
        future: widget.futureManifest,
        builder: (context, snapshot) {
          final manifest = snapshot.data;
          if (manifest != null) {
            final stream = manifest.muxed.bestQuality;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title: ${video.title}'),
                  Text('Author: ${video.author}'),
                  Text('Duration: ${video.duration}'),
                  Text('Resolution: ${stream.videoResolution}'),
                  Text('Bitrate: ${stream.bitrate}'),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: AppStrings.songTitleHint.tr),
                  ),
                  TextField(
                    controller: artistController,
                    decoration: InputDecoration(labelText: AppStrings.artistNameHint.tr),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel.tr),
        ),
        FutureBuilder(
            future: widget.futureManifest,
            builder: (context, snapshot) {
              final manifest = snapshot.data;
              final stream = manifest?.muxed.bestQuality;
              return TextButton(
                onPressed: manifest == null
                    ? null
                    : () {
                        final song = YoutubeSongDto(
                          title: titleController.text,
                          artist: artistController.text,
                          thumbnail: video.thumbnails.mediumResUrl,
                          duration: video.duration?.inSeconds ?? 0,
                          url: stream?.url.toString(),
                        );
                        widget.service.sendYoutubeSong(song).then((value) => Navigator.of(context).pop());
                      },
                child: Text(AppStrings.save.tr),
              );
            }),
      ],
    );
  }
}
