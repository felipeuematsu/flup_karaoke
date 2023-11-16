import 'dart:math';

import 'package:flup_karaoke/features/commons/controller/current_singer_controller.dart';
import 'package:flup_karaoke/features/commons/widgets/no_default_singer_dialog.dart';
import 'package:flup_karaoke/features/commons/widgets/song_list_tile.dart';
import 'package:flup_karaoke/features/playlist/view/components/add_to_queue_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DismissibleSongTile extends StatefulWidget {
  const DismissibleSongTile({super.key, required this.song});

  final SongModel song;

  @override
  State<DismissibleSongTile> createState() => _DismissibleSongTileState();
}

class _DismissibleSongTileState extends State<DismissibleSongTile> {
  final service = GetIt.I<KaraokeApiService>();
  final currentSingerController = GetIt.I<CurrentSingerController>();

  final controller = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => quickAddToQueue(context, widget.song.songId),
      onUpdate: (details) => controller.value = details.progress,
      direction: DismissDirection.startToEnd,
      dismissThresholds: const {DismissDirection.startToEnd: 0.3},
      background: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) =>
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 32.0),
              color: Color.lerp(Colors.grey, Colors.lightGreen, max(value < 0.3 ? 1 : 0.0, min(0.3, pow(5.0 * (value - 0.1), 3).toDouble()))),
              child: const Icon(Icons.playlist_add, color: Colors.white),
            ),
      ),
      confirmDismiss: (direction) => Future.value(false),
      key: ValueKey(widget.song.songId ?? 0),
      child: SongListTile(
        song: widget.song,
        onTap: () =>
            showCupertinoModalBottomSheet(
              context: context,
              backgroundColor: Theme
                  .of(context)
                  .platform == TargetPlatform.iOS ? CupertinoColors.systemBackground : null,
              builder: (context) => AddToQueueBottomSheet(song: widget.song),
            ),
      ),
    );
  }

  Future<void> quickAddToQueue(BuildContext context, int? songId) async {
    final currentSinger = currentSingerController.currentSinger;

    if (currentSinger == null) {
      return showAdaptiveDialog(context: context, builder: (context) => const NoDefaultSingerDialog());
    }

    return service.addToQueue(songId ?? 0, currentSinger.name ?? '');
  }
}
