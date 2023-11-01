import 'package:flup_karaoke/features/now_playing/controller/mini_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class NowPlayingImageSlider extends StatelessWidget {
  const NowPlayingImageSlider({
    super.key,
    required this.service,
    required this.nowPlayingController,
  });

  final KaraokeApiService service;
  final NowPlayingController nowPlayingController;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        angleRange: 210,
        customColors: CustomSliderColors(
          trackColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          progressBarColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          dotColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      onChangeEnd: (value) => service.setVolume(value.floor()),
      initialValue: nowPlayingController.currentVolume.value?.toDouble() ?? 0,
      innerWidget: (_) => Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), blurRadius: 16, spreadRadius: 8)],
          ),
          child: ValueListenableBuilder(
            valueListenable: nowPlayingController.nowPlayingSong,
            child: const Icon(Icons.music_note, size: 128),
            builder: (context, value, child) {
              if (value?.song?.imageUrl case final imageUrl?) {
                return Image.network(imageUrl, fit: BoxFit.cover, height: 128, width: 128, errorBuilder: (_, __, ___) => child!);
              }
              return child!;
            },
          ),
        ),
      ),
    );
  }
}
