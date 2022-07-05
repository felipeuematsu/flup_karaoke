import 'dart:io';

import 'package:flutter/material.dart';

class PlaylistScrollLoadingItem extends StatelessWidget {
  const PlaylistScrollLoadingItem({Key? key}) : super(key: key);

  double get size => Platform.isAndroid || Platform.isIOS ? 120.0 : 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
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
