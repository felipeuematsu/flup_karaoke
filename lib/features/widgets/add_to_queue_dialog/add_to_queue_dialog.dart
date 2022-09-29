import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class AddToQueueDialog extends StatefulWidget {
  const AddToQueueDialog({Key? key, required this.service, required this.song}) : super(key: key);

  final SongModel song;
  final KaraokeApiService service;

  @override
  State<AddToQueueDialog> createState() => _AddToQueueDialogState();
}

class _AddToQueueDialogState extends State<AddToQueueDialog> {
  String? singer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add to queue'),
      content: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.song.artist ?? ''),
            const SizedBox(height: 8),
            Text(widget.song.title ?? ''),
            const SizedBox(height: 8),
            FutureBuilder(
              future: widget.service.getSingers(),
              builder: (context, AsyncSnapshot<List<SingerModel>> snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return DropdownButton(
                      value: singer,
                      hint: const Text('Select singer'),
                      items: data.map((e) => DropdownMenuItem(value: e.name, child: Text(e.name ?? ''))).toList(),
                      onChanged: (value) {
                        setState(() => singer = value);
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            final id = singer;
            if (id != null) {
              try {
                widget.service.addToQueue(widget.song.songId ?? 0, id).then((_) => Navigator.of(context).pop());
              } catch (e) {
                print(e);
              }
            } else {
              showBottomSheet(context: context, builder: (context) => const Text('Please select a singer'));
            }
          },
        ),
      ],
    );
  }
}
