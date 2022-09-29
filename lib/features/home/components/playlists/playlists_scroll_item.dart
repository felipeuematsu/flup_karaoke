import 'dart:io';

import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/home/components/playlists/scroll_item_type.dart';

class PlaylistScrollItem extends StatelessWidget {
  const PlaylistScrollItem({Key? key, required this.name, required this.onPressed, this.scrollItemType = ScrollItemType.playlist, this.url}) : super(key: key);

  final ScrollItemType scrollItemType;
  final VoidCallback Function(BuildContext context) onPressed;
  final String name;
  final String? url;

  double get size => Platform.isAndroid || Platform.isIOS ? 120.0 : 200.0;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    final BoxDecoration decoration;
    if (url != null) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      );
    } else {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.all(12.0),
        decoration: decoration,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(8.0),
          clipBehavior: Clip.hardEdge,
          onPressed: onPressed(context),
          child: url != null ? null : Center(child: Text(name, style: Theme.of(context).textTheme.titleSmall)),
        ),
      ),
    );
  }
}
