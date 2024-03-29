import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/commons/controller/current_singer_controller.dart';
import 'package:flup_karaoke/features/commons/widgets/dismissible_song_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

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
  final currentSingerController = GetIt.I<CurrentSingerController>();

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
          return CustomScrollView(slivers: [
            SliverAppBar(
              expandedHeight: imageUrl == null ? null : 300.0,
              pinned: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.white38,
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: imageUrl == null ? const Icon(Icons.music_note, size: 64.0) : Image.network(imageUrl, fit: BoxFit.cover),
                ),
                title: Text(playlist?.name ?? '', style: const TextStyle(color: Colors.black)),
                stretchModes: const [StretchMode.fadeTitle],
                collapseMode: CollapseMode.pin,
              ),
            ),
            Builder(builder: (context) {
              if (playlist == null) return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));

              return SliverList(delegate: SliverChildBuilderDelegate(childCount: songs.length, (_, index) => DismissibleSongTile(song: songs[index])));
            }),
          ]);
        },
      ),
    );
  }
}
