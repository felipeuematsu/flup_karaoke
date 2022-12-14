import 'dart:math';

import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/features/home/components/playlists/playlists_scroll_item.dart';
import 'package:flup_karaoke/features/home/components/playlists/playlists_scroll_loading_item.dart';
import 'package:flup_karaoke/features/home/controller/playlists_controller.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistsHorizontalScrollView extends StatefulWidget {
  const PlaylistsHorizontalScrollView({Key? key, required this.playlistsController, required this.title}) : super(key: key);

  final String title;

  final PlaylistsController playlistsController;

  @override
  State<PlaylistsHorizontalScrollView> createState() => _PlaylistsHorizontalScrollViewState();
}

class _PlaylistsHorizontalScrollViewState extends State<PlaylistsHorizontalScrollView> {
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => widget.playlistsController.execute(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: Text(widget.title, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            height: PlaylistScrollItem.fullSize,
            width: double.infinity,
            child: StreamBuilder(
              stream: widget.playlistsController.playlistsStream,
              builder: (context, AsyncSnapshot<List<SimplePlaylistModel>?> snapshot) {
                final data = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: max(data?.length ?? 5, 1),
                  itemBuilder: (context, index) {
                    if (data == null) return const PlaylistScrollLoadingItem();
                    if (data.isEmpty) return Center(child: Text(AppStrings.noPlaylistsFound.tr(context)));
                    final playlist = data[index];
                    final id = playlist.id;
                    if (id == null) return const SizedBox.shrink();
                    return PlaylistScrollItem(
                      url: playlist.imageUrl,
                      name: playlist.name ?? '',
                      onPressed: (context) => widget.playlistsController.onPlaylistTapped(context, playlistId: id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.playlistsController.init();
  }

  @override
  void dispose() {
    widget.playlistsController.dispose();
    super.dispose();
  }
}
