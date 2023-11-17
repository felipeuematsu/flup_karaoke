import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class RemoveFromQueueDialog extends StatelessWidget {
  const RemoveFromQueueDialog({super.key, required this.song});

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(FlupS.of(context).removeFromQueue),
      content: Text(FlupS.of(context).removeFromQueueMessage(song.title ?? '')),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(FlupS.of(context).cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(FlupS.of(context).remove),
        ),
      ],
    );
  }
}
