import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/extensions/duration.dart';
import 'package:flup_karaoke/features/now_playing/controller/mini_player_controller.dart';
import 'package:flup_karaoke/features/now_playing/view/components/now_playing_image_slider.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
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
    final titleColor = Theme.of(context).colorScheme.onBackground;
    final subtitleColor = Theme.of(context).colorScheme.onBackground.withOpacity(0.5);
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).nowPlaying), actions: [
        IconButton(
          icon: const Icon(Icons.queue_music),
          onPressed: () => AutoRouter.of(context).push(const QueueRoute()),
        ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox.square(
              dimension: MediaQuery.of(context).size.width - 64,
              child: Stack(children: [
                Positioned.fill(child: NowPlayingImageSlider(service: service, nowPlayingController: nowPlayingController)),
                Positioned(
                  left: 0,
                  right: 0,
                  top: (MediaQuery.of(context).size.width - 64) * 0.7,
                  child: const IgnorePointer(child: Row(children: [Icon(Icons.volume_down, size: 32), Spacer(), Icon(Icons.volume_up, size: 32)])),
                ),
              ]),
            ),
            const MaxGap(32),
            ValueListenableBuilder(
              valueListenable: nowPlayingController.nowPlayingSong,
              builder: (context, value, _) => Text(
                value?.song?.title ?? FlupS.of(context).noSongPlaying,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: titleColor),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const MaxGap(8),
            ValueListenableBuilder(
              valueListenable: nowPlayingController.nowPlayingSong,
              builder: (context, value, _) => Text(
                value?.song?.artist ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: subtitleColor),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const MaxGap(16),
            ValueListenableBuilder(
              valueListenable: nowPlayingController.nowPlayingSong,
              builder: (context, value, _) => LinearProgressIndicator(
                value: (value?.position ?? 0 / (value?.song?.duration ?? 1)).toDouble(),
                borderRadius: BorderRadius.circular(16),
                minHeight: 8,
                backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
              ),
            ),
            const MaxGap(4),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: subtitleColor) ?? const TextStyle(),
              child: ValueListenableBuilder(
                valueListenable: nowPlayingController.nowPlayingSong,
                builder: (context, value, _) => Row(children: [
                  Text(Duration(seconds: value?.position ?? 0).toMinutesSeconds()),
                  const Spacer(),
                  Text('-${Duration(seconds: value?.song?.duration ?? 0).toMinutesSeconds()}'),
                ]),
              ),
            ),
            const MaxGap(48),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(Icons.restart_alt),
                onPressed: service.restart,
                iconSize: 48,
                color: titleColor,
              ),
              const MaxGap(16),
              ValueListenableBuilder(
                valueListenable: nowPlayingController.nowPlayingSong,
                builder: (context, value, _) => IconButton(
                  iconSize: 96,
                  icon: value?.isPlaying == true ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                  onPressed: value?.isPlaying == true ? service.pause : service.play,
                  color: titleColor,
                ),
              ),
              const MaxGap(16),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: service.skip,
                iconSize: 48,
                color: titleColor,
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
