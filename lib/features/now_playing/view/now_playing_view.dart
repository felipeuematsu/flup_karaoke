import 'package:flup_karaoke/extensions/duration.dart';
import 'package:flup_karaoke/features/now_playing/controller/mini_player_controller.dart';
import 'package:flup_karaoke/features/now_playing/view/components/now_playing_image_slider.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({super.key});

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  final service = GetIt.I<KaraokeApiService>();
  final nowPlayingController = GetIt.I<NowPlayingController>();

  @override
  Widget build(BuildContext context) {
    final subtitleColor = Theme.of(context).colorScheme.onBackground.withOpacity(0.5);
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).nowPlaying)),
      body: ListView(padding: const EdgeInsets.all(32), children: [
        Stack(children: [
          Positioned.fill(child: NowPlayingImageSlider(service: service, nowPlayingController: nowPlayingController)),
          Positioned(
            left: 0,
            right: 0,
            top: (MediaQuery.of(context).size.width - 64) * 0.6,
            child: const Row(children: [Icon(Icons.volume_down, size: 48), Spacer(), Icon(Icons.volume_up, size: 48)]),
          ),
        ]),
        const Gap(32),
        ValueListenableBuilder(
          valueListenable: nowPlayingController.nowPlayingSong,
          builder: (context, value, _) => Text(
            value?.song?.title ?? '',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const Gap(8),
        ValueListenableBuilder(
          valueListenable: nowPlayingController.nowPlayingSong,
          builder: (context, value, _) => Text(
            value?.song?.artist ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: subtitleColor),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const Gap(16),
        ValueListenableBuilder(
          valueListenable: nowPlayingController.nowPlayingSong,
          builder: (context, value, _) => LinearProgressIndicator(
            value: (value?.position ?? 0 / (value?.song?.duration ?? 1)).toDouble(),
            borderRadius: BorderRadius.circular(16),
            minHeight: 4,
            backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const Gap(4),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: subtitleColor) ?? const TextStyle(),
          child: ValueListenableBuilder(
            valueListenable: nowPlayingController.nowPlayingSong,
            builder: (context, value, _) => Row(children: [
              Text(Duration(seconds: value?.position ?? 0).toMinutesSeconds()),
              const Spacer(),
              Text('- ${Duration(seconds: value?.song?.duration ?? 0).toMinutesSeconds()}'),
            ]),
          ),
        ),
        const Gap(48),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: service.restart,
          ),
          const Gap(16),
          ValueListenableBuilder(
            valueListenable: nowPlayingController.nowPlayingSong,
            builder: (context, value, _) => IconButton(
              icon: (value?.isPlaying ?? false) ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              onPressed: () => (value?.isPlaying ?? false) ? service.pause() : service.play(),
            ),
          ),
          const Gap(16),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: service.skip,
          ),
        ]),
      ]),
    );
  }
}
