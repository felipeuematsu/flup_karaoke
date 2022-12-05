import 'dart:async';

import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/playlist/components/song_tile.dart';
import 'package:flup_karaoke/features/queue/components/queue_dialog.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class QueueView extends StatefulWidget {
  const QueueView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  State<QueueView> createState() => _QueueViewState();
}

class _QueueViewState extends State<QueueView> {
  KaraokeApiService get service => widget.service;

  final _queueItemsStream = StreamController<List<SongQueueItem>>();

  @override
  void initState() {
    super.initState();
    service.getQueue().then((value) => _queueItemsStream.add(value));
  }

  Widget _singleChildScroll(Widget item) {
    return SizedBox.expand(child: ListView(children: [Center(child: item)]));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => service.getQueue().then((value) => _queueItemsStream.add(value)),
      child: StreamBuilder(
        stream: _queueItemsStream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return _singleChildScroll(const CircularProgressIndicator());
          final data = snapshot.data;
          if (data == null) return _singleChildScroll(const CircularProgressIndicator());
          if (data.isEmpty) return _singleChildScroll(Padding(padding: const EdgeInsets.all(80.0), child: Text(AppStrings.emptyQueueMessage.tr)));

          return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) => service.reorderQueue(data[oldIndex].id ?? 0, newIndex).then((_) => service.getQueue().then((value) => _queueItemsStream.add(value))),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return SongTile(
                key: ValueKey(data[index].id),
                song: data[index].song,
                singerModel: data[index].singer,
                onTap: () => showDialog(context: context, builder: (context) => QueueDialog(item: data[index], service: service))
                    .then((value) => service.getQueue().then((value) => _queueItemsStream.add(value))),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _queueItemsStream.close();
    super.dispose();
  }
}
