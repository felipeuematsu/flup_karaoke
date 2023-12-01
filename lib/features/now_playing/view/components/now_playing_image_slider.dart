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
        startAngle: 165,
        customWidths: CustomSliderWidths(progressBarWidth: 8, trackWidth: 8, handlerSize: 0),
        customColors: CustomSliderColors(
          trackColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          progressBarColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          dotColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      onChangeEnd: (value) => service.setVolume(value.floor()),
      initialValue: nowPlayingController.currentVolume.value?.toDouble() ?? 0,
      innerWidget: (_) => Center(
        child: ValueListenableBuilder(
          valueListenable: nowPlayingController.nowPlayingSong,
          builder: (context, value, child) {
            final size = MediaQuery.of(context).size.width * 0.4;
            final note = Icon(Icons.music_note, size: size);
            if (value == null) return Icon(Icons.music_off, size: size);
            if (value.song?.imageUrl case final imageUrl?) {
              return DecoratedBox(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(imageUrl, fit: BoxFit.cover, height: size, width: size, errorBuilder: (_, __, ___) => note),
              );
            }
            return note;
          },
        ),
      ),
    );
  }
}
