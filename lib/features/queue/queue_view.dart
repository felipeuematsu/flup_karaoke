import 'dart:async';

import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/playlist/components/song_tile.dart';
import 'package:flup_karaoke/features/queue/components/queue_dialog.dart';

class QueueView extends StatefulWidget {
  const QueueView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  State<QueueView> createState() => _QueueViewState();
}

class _QueueViewState extends State<QueueView> {
  final queueItemsStream = StreamController<List<SongQueueItem>>();

  @override
  void initState() {
    super.initState();
    widget.service.getQueue().then((value) => queueItemsStream.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.service.getQueue().then((value) => queueItemsStream.add(value)),
      child: StreamBuilder<List<SongQueueItem>?>(
        stream: queueItemsStream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data != null) {
            if (data.isEmpty) {
              return Center(child: Text(AppStrings.emptyQueueMessage.tr));
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return SongTile(
                  song: item.song,
                  singerModel: item.singer,
                  onTap: () => showDialog(context: context, builder: (context) => QueueDialog(item: item, service: widget.service))
                      .then((value) => widget.service.getQueue().then((value) => queueItemsStream.add(value))),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    queueItemsStream.close();
    super.dispose();
  }
}
