import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/playlist/view/components/playlist_item_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
class PlaylistDetailsView extends StatefulWidget {
  const PlaylistDetailsView({super.key, required this.playlist, required this.id});

  final SimplePlaylistModel playlist;
  final int id;

  @override
  State<PlaylistDetailsView> createState() => _PlaylistDetailsViewState();
}

class _PlaylistDetailsViewState extends State<PlaylistDetailsView> {
  final service = GetIt.I<KaraokeApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.playlist.name ?? '')),
      body: Column(children: [
        FutureBuilder(
          future: service.getPlaylist(widget.playlist.id ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return PlaylistItemList(songs: snapshot.data?.songs ?? []);
          },
        ),
      ]),
    );
  }
}
