import 'package:flup_karaoke/features/playlist/view/components/playlist_item_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key, required this.playlist});

  final SimplePlaylistModel playlist;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final KaraokeApiService service = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
          future: service.getPlaylist(widget.playlist.id ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final songs = snapshot.data?.songs ?? [];
            return PlaylistItemList(songs: songs);
          },
        ),
      ]),
    );
  }
}
