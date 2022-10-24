import 'package:flutter/material.dart';
import 'package:flup_karaoke/features/home/components/playlists/playlists_scroll_item.dart';
import 'package:flup_karaoke/features/home/components/playlists/scroll_item_type.dart';

class PlaylistScrollLoadingItem extends StatelessWidget {
  const PlaylistScrollLoadingItem({Key? key, this.scrollItemType = ScrollItemType.playlist}) : super(key: key);

  final ScrollItemType scrollItemType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PlaylistScrollItem.size,
      width: PlaylistScrollItem.size,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Theme.of(context).colorScheme.primary.withOpacity(0.2), Theme.of(context).colorScheme.secondary.withOpacity(0.2)],
        ),
      ),
      child: Center(child: CircularProgressIndicator(color: Colors.grey.shade300)),
    );
  }
}
