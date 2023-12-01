import 'package:flutter/material.dart';

class PlayingStatusWidget extends StatelessWidget {
  const PlayingStatusWidget({super.key, required this.isPlaying, this.dimension, required this.value});

  final bool isPlaying;

  final double? dimension;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Stack(children: [
        Positioned.fill(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary.withOpacity(0.4), value: value, strokeWidth: 1)),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(isPlaying ? Icons.play_arrow : Icons.pause, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ]),
    );
  }
}
