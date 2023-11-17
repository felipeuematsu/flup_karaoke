import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class PlaylistListTile extends StatelessWidget {
  const PlaylistListTile({
    super.key,
    required this.simplePlaylistModel,
  });

  final SimplePlaylistModel simplePlaylistModel;

  @override
  Widget build(BuildContext context) {
    final imageUrl = simplePlaylistModel.imageUrl;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white38,
          child: imageUrl != null ? Image.network(imageUrl, fit: BoxFit.cover, height: 48, width: 48) : const Icon(Icons.music_note, size: 48),
        ),
      ),
      title: SizedBox(height: 48, child: Align(alignment: Alignment.centerLeft, child: Text(simplePlaylistModel.name ?? ''))),
      onTap: () => AutoRouter.of(context).push(PlaylistDetailsRoute(playlist: simplePlaylistModel, id: simplePlaylistModel.id ?? 0)),
    );
  }
}
