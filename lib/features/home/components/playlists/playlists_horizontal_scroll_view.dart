import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_scroll_item.dart';
import 'package:karaoke_request_client/features/home/controller/playlists_controller.dart';

class PlaylistsHorizontalScrollView extends StatelessWidget {
  const PlaylistsHorizontalScrollView({Key? key, required this.playlistsController, required this.title}) : super(key: key);

  final String title;

  final PlaylistsController playlistsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: Text(title, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
        ),
        SizedBox(
          width: double.infinity,
          child: StreamBuilder(
            stream: playlistsController.playlistsStream,
            builder: (context, AsyncSnapshot<List<SimplePlaylistModel>?> snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final playlist = data[index];
                    final id = playlist.id;
                    if (id == null) return const SizedBox.shrink();
                    return PlaylistScrollItem(url: playlist.imageUrl, name: playlist.name ?? '', onPressed: (context) => playlistsController.onPlaylistTapped(context, playlistId: id));
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
