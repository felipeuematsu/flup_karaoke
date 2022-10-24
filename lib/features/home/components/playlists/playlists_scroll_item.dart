import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/home/components/playlists/scroll_item_type.dart';

class PlaylistScrollItem extends StatelessWidget {
  const PlaylistScrollItem({Key? key, required this.name, required this.onPressed, this.scrollItemType = ScrollItemType.playlist, this.url}) : super(key: key);

  final ScrollItemType scrollItemType;
  final VoidCallback Function(BuildContext context) onPressed;
  final String name;
  final String? url;

  static double get size => kIsWeb ? 200.0 : 120.0;
  static double get fullSize => 24.0 + (kIsWeb ? 200.0 : 120.0);

  Color _primaryColor(BuildContext context) => Theme.of(context).colorScheme.primary.withOpacity(0.2);

  Color _secondaryColor(BuildContext context) => Theme.of(context).colorScheme.secondary.withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    return Material(
      color: Colors.transparent,
      child: Container(
        height: size,
        width: size,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: url == null ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [_primaryColor(context), _secondaryColor(context)]) : null,
          image: url != null ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover) : null,
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(8.0),
          clipBehavior: Clip.hardEdge,
          onPressed: onPressed(context),
          child: url == null ? Center(child: Text(name, style: Theme.of(context).textTheme.titleSmall)) : null,
        ),
      ),
    );
  }
}
