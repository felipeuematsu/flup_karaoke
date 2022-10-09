import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/playlist/components/song_tile.dart';
import 'package:karaoke_request_client/features/widgets/add_to_queue_dialog/add_to_queue_dialog.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.futurePlaylist, required this.service}) : super(key: key);

  final KaraokeApiService service;
  final Future<PlaylistModel> futurePlaylist;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PlaylistModel?>(
        future: widget.futurePlaylist,
        builder: (context, snapshot) {
          final PlaylistModel? playlist = snapshot.data;
          final songs = playlist?.songs ?? [];
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: playlist?.imageUrl == null ? null : 300.0,
                pinned: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: playlist?.imageUrl != null
                      ? Container(
                          color: Colors.white38,
                          padding: const EdgeInsets.only(bottom: 64.0),
                          child: Image.network(playlist?.imageUrl ?? '', fit: BoxFit.cover),
                        )
                      : null,
                  title: Text(playlist?.name ?? '', style: const TextStyle(color: Colors.black)),
                  stretchModes: const [StretchMode.fadeTitle],
                  collapseMode: CollapseMode.pin,
                ),
              ),
              if (playlist != null)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => SongTile(song: songs[index], onTap: () => showDialog(context: context, builder: (_) => AddToQueueDialog(service: widget.service, song: songs[index]))),
                    childCount: songs.length,
                  ),
                )
              else
                const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            ],
          );
        },
      ),
    );
  }
}
