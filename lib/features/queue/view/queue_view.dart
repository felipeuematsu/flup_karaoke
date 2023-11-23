import 'package:auto_route/annotations.dart';
import 'package:flup_karaoke/features/commons/widgets/song_list_tile.dart';
import 'package:flup_karaoke/features/queue/controller/queue_controller.dart';
import 'package:flup_karaoke/features/queue/view/components/empty_queue_widget.dart';
import 'package:flup_karaoke/features/queue/view/components/remove_from_queue_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class QueueView extends StatefulWidget {
  const QueueView({super.key});

  @override
  State<QueueView> createState() => _QueueViewState();
}

class _QueueViewState extends State<QueueView> {
  final controller = QueueController();

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    controller.getQueue();
  }

  Future<void> _onTapItem(SongQueueItem song) async {
    return showCupertinoModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (context) => Material(
        child: SafeArea(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(FlupS.of(context).youCanReorderTheQueue),
                subtitle: Text(FlupS.of(context).youCanReorderTheQueueMessage),
              ),
              const Divider(),
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                leading: const Icon(Icons.playlist_remove),
                onTap: () async {
                  final shouldRemove = await showAdaptiveDialog(context: context, builder: (_) => RemoveFromQueueDialog(song: song.song));
                  if (shouldRemove != true) return;
                  await controller.service.removeFromQueue(song.id ?? 0);
                  await refreshKey.currentState?.show();
                },
                title: Text(FlupS.of(context).removeFromQueue),
              ),
              const Divider(),
              ListTile(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                leading: const Icon(Icons.cancel),
                onTap: () => Navigator.pop(context),
                title: Text(FlupS.of(context).cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: refreshKey.currentState?.show,
      child: Scaffold(
        appBar: AppBar(title: Text(FlupS.of(context).queue)),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: controller.getQueue,
          child: ValueListenableBuilder(
            valueListenable: controller.queue,
            builder: (context, value, child) {
              if (value == null) return const Center(child: CircularProgressIndicator.adaptive());

              if (value.isEmpty) return const EmptyQueueWidget();

              Future<void> onReorder(int oldIndex, int newIndex) async {
                await controller.reorderQueue(value[oldIndex].id ?? 0, newIndex);
                refreshKey.currentState?.show();
              }

              return ReorderableListView.builder(
                onReorder: onReorder,
                itemCount: value.length,
                itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(value[index].id),
                  confirmDismiss: (_) async {
                    final shouldRemove = await showAdaptiveDialog(context: context, builder: (_) => RemoveFromQueueDialog(song: value[index].song));
                    return shouldRemove == true;
                  },
                  onDismissed: (_) async {
                    await controller.service.removeFromQueue(value[index].id ?? 0);
                    await refreshKey.currentState?.show();
                  },
                  background: Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(Icons.playlist_remove, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {DismissDirection.endToStart: 0.4},
                  child: SongListTile(song: value[index].song, singer: value[index].singer, onTap: () => _onTapItem(value[index])),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
