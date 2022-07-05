import 'dart:io';

import 'package:flutter/material.dart';

class PlaylistScrollItem extends StatelessWidget {
  const PlaylistScrollItem({Key? key, required this.name, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;
  final String name;

  double get size => Platform.isAndroid || Platform.isIOS ? 120.0 : 200.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          ),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(8.0),
          clipBehavior: Clip.hardEdge,
          onPressed: onPressed,
          child: Center(child: Text(name, style: Theme.of(context).textTheme.titleSmall)),
        ),
      ),
    );
  }
}
