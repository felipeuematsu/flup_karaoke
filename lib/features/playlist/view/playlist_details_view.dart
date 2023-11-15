import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/commons/controller/current_singer_controller.dart';
import 'package:flup_karaoke/features/commons/widgets/song_list_tile.dart';
import 'package:flup_karaoke/features/playlist/view/components/add_to_queue_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class PlaylistDetailsView extends StatefulWidget {
  const PlaylistDetailsView({Key? key, @PathParam() required this.id, this.playlist}) : super(key: key);

  final SimplePlaylistModel? playlist;
  final int id;

  @override
  State<PlaylistDetailsView> createState() => _PlaylistDetailsViewState();
}

class _PlaylistDetailsViewState extends State<PlaylistDetailsView> {
  final service = GetIt.I<KaraokeApiService>();
  final currentSingerController = CurrentSingerController();

  final playlistDetails = ValueNotifier<PlaylistModel?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PlaylistModel?>(
        future: service.getPlaylist(widget.id),
        builder: (context, snapshot) {
          final playlist = snapshot.data;
          final songs = playlist?.songs ?? [];
          final imageUrl = playlist?.imageUrl;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: imageUrl == null ? null : 300.0,
                pinned: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: imageUrl == null
                      ? null
                      : Container(
                          color: Colors.white38,
                          padding: const EdgeInsets.only(bottom: 64.0),
                          child: Image.network(imageUrl, fit: BoxFit.cover),
                        ),
                  title: Text(playlist?.name ?? '', style: const TextStyle(color: Colors.black)),
                  stretchModes: const [StretchMode.fadeTitle],
                  collapseMode: CollapseMode.pin,
                ),
              ),
              Builder(builder: (context) {
                if (playlist == null) return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: songs.length,
                    (context, index) {
                      final controller = ValueNotifier(0.0);
                      return Dismissible(
                        onDismissed: (direction) => service.addToQueue(songs[index].songId ?? 0, currentSingerController.currentSinger?.name ?? ''),
                        onUpdate: (details) => controller.value = details.progress,
                        direction: DismissDirection.startToEnd,
                        dismissThresholds: const {DismissDirection.startToEnd: 0.3},
                        background: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, value, child) => Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 32.0),
                            color: value < 0.3
                                ? Color.lerp(Colors.grey, Colors.lightGreen, max(0.0, min(0.3, pow(5.0 * (value - 0.1), 3).toDouble())))
                                : Colors.lightGreen,
                            child: const Icon(Icons.playlist_add, color: Colors.white),
                          ),
                        ),
                        confirmDismiss: (direction) => Future.value(false),
                        key: ValueKey(songs[index].songId ?? 0),
                        child: SongListTile(
                          song: songs[index],
                          onTap: () => showCupertinoModalBottomSheet(
                            context: context,
                            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? CupertinoColors.systemBackground : null,
                            builder: (context) => AddToQueueBottomSheet(song: songs[index]),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
