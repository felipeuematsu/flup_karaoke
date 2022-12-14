import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class QueueDialog extends StatefulWidget {
  const QueueDialog({Key? key, required this.item, required this.service}) : super(key: key);

  final KaraokeApiService service;
  final SongQueueItem item;

  @override
  State<QueueDialog> createState() => _QueueDialogState();
}

class _QueueDialogState extends State<QueueDialog> {
  bool isMidRequest = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.item.song.artist ?? ''),
            const SizedBox(height: 8),
            Text(widget.item.song.title ?? ''),
            const SizedBox(height: 8),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.cancel.tr(context)),
        ),
        TextButton(
          onPressed: isMidRequest
              ? null
              : () {
                  setState(() => isMidRequest = true);
                  widget.service.removeFromQueue(widget.item.id ?? 0).then((_) {
                    setState(() => isMidRequest = false);
                    Navigator.pop(context);
                  });
                },
          child: Text(AppStrings.removeFromQueue.tr(context)),
        ),
      ],
    );
  }
}
