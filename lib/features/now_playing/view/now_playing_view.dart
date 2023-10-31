import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).nowPlaying)),
      body: Column(children: [
        const Text('Now Playing'),
      ]),
    );
  }
}
