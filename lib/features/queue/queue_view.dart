import 'dart:async';

import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/playlist/components/song_tile.dart';
import 'package:flup_karaoke/features/queue/components/queue_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class QueueView extends StatefulWidget {
  const QueueView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  State<QueueView> createState() => _QueueViewState();
}

class _QueueViewState extends State<QueueView> {
  KaraokeApiService get service => widget.service;

  final _queueItemsStream = StreamController<List<SongQueueItem>?>();
  final indicator = GlobalKey<RefreshIndicatorState>();

  Future<void> Function() get reload => () async {
        // _queueItemsStream.add(null);
        indicator.currentState?.show();
      };

  @override
  void initState() {
    super.initState();
    reload();
  }

  Widget _singleChildScroll(Widget item) {
    return SizedBox.expand(child: ListView(children: [Center(child: item)]));
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: reload,
      child: RefreshIndicator(
        key: indicator,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () => service.getQueue().then((value) => _queueItemsStream.add(value)),
        child: StreamBuilder(
          stream: _queueItemsStream.stream,
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting || data == null) return _singleChildScroll(const SizedBox());
            if (data.isEmpty) return _singleChildScroll(Padding(padding: const EdgeInsets.all(80.0), child: Text(AppStrings.emptyQueueMessage.tr(context))));

            data.sort((a, b) => (a.position ?? 0) - (b.position ?? 0));

            return ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) => service.reorderQueue(data[oldIndex].id ?? 0, newIndex).then((_) => reload()),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return SongTile(
                  key: ValueKey(data[index].id),
                  song: data[index].song,
                  singerModel: data[index].singer,
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                      context: context,
                      builder: (context) {
                        return ListView(
                          padding: const EdgeInsets.all(20.0),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              leading: const Icon(Icons.playlist_remove_sharp),
                              onTap: () => showDialog(context: context, builder: (_) => QueueDialog(item: data[index], service: service)).then((_) => reload()),
                              title: Text(AppStrings.removeFromQueue.tr(context)),
                            ),
                            const Divider(color: Colors.black),
                            ListTile(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              leading: const Icon(Icons.cancel),
                              onTap: () => Navigator.pop(context),
                              title: Text(AppStrings.cancel.tr(context)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _queueItemsStream.close();
    super.dispose();
  }
}
