import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/components/playlists_scroll_item.dart';
import 'package:karaoke_request_client/features/models/simple_playlist_model.dart';
import 'package:karaoke_request_client/features/models/song_model.dart';
import 'package:karaoke_request_client/features/playlist/components/playlist_song_tile.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.playlistModel, required this.futureSongs}) : super(key: key);

  final SimplePlaylistModel playlistModel;
  final Future<List<SongModel>?> futureSongs;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.futureSongs,
        builder: (context, snapshot) {
          final List<SongModel>? snapshotData = snapshot.data;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                // expandedHeight: 200.0,
                pinned: true,
                backgroundColor: Colors.transparent,
                stretch: false,
                foregroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.playlistModel.title ?? '', style: const TextStyle(color: Colors.black)),
                  stretchModes: const [StretchMode.fadeTitle],
                  collapseMode: CollapseMode.pin,
                ),
              ),
              if (snapshotData != null)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PlaylistSongTile(song: snapshotData[index]),
                    childCount: snapshotData.length,
                  ),
                ),
              if (snapshotData == null)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );

          if (snapshot.hasData && snapshotData != null) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshotData.length,
              itemBuilder: (context, index) => PlaylistSongTile(song: snapshotData[index]),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(AppStrings.genericErrorMessage.tr));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
