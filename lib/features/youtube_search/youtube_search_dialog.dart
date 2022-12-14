import 'package:dio/dio.dart';
import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
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
  Video get video => widget.video;

  String get videoTitle => video.title;

  String? get possibleArtist => videoTitle.contains(' - ') ? videoTitle.split(' - ').first : null;

  String? get possibleTitle => '${videoTitle.contains(' - ') ? videoTitle.split(' - ').last : videoTitle} [${video.author}]';

  late final titleController = TextEditingController(text: possibleTitle);
  late final artistController = TextEditingController(text: possibleArtist);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.addYoutubeSong.tr(context)),
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
                    decoration: InputDecoration(labelText: AppStrings.songTitleHint.tr(context)),
                  ),
                  TextField(
                    controller: artistController,
                    decoration: InputDecoration(labelText: AppStrings.artistNameHint.tr(context)),
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
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel.tr(context)),
        ),
        FutureBuilder(
            future: widget.futureManifest,
            builder: (context, snapshot) {
              final manifest = snapshot.data;
              final stream = manifest?.muxed.bestQuality;
              return TextButton(
                onPressed: manifest == null || isLoading
                    ? null
                    : () async {
                        final song = YoutubeSongDto(
                          title: titleController.text,
                          artist: artistController.text,
                          thumbnail: video.thumbnails.mediumResUrl,
                          duration: video.duration?.inSeconds ?? 0,
                          url: stream?.url.toString(),
                        );
                        try {
                          setState(() => isLoading = true);
                          Navigator.of(context).pop(await widget.service.sendYoutubeSong(song));
                        } on DioError {
                          setState(() => isLoading = false);
                        }
                      },
                child: Text(AppStrings.save.tr(context)),
              );
            }),
      ],
    );
  }
}
