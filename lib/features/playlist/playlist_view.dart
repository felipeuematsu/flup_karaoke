import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/home/use_case/get_complete_playlist.dart';
import 'package:flup_karaoke/features/playlist/components/song_tile.dart';
import 'package:flup_karaoke/features/widgets/add_to_queue_dialog/add_to_queue_dialog.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, @PathParam() required this.id, required this.service, required this.getDetailedPlaylistUseCase}) : super(key: key);

  final KaraokeApiService service;
  final GetDetailedPlaylistUseCase getDetailedPlaylistUseCase;
  final int id;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PlaylistModel?>(
        future: widget.getDetailedPlaylistUseCase.execute(widget.id),
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
