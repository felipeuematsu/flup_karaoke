import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class MiniPlayerView extends StatefulWidget implements PreferredSizeWidget {
  const MiniPlayerView({super.key});

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();

  @override
  Size get preferredSize => const Size.fromHeight(148);
}

class _MiniPlayerViewState extends State<MiniPlayerView> {
  final KaraokeApiService service = GetIt.I<KaraokeApiService>();

  final nowPlayingSong = ValueNotifier<NowPlayingSongModel?>(null);

  late final timer = Timer.periodic(const Duration(seconds: 1), (_) async => nowPlayingSong.value = await service.getNowPlayingSong());

  double percentage(NowPlayingSongModel? value) => (value?.position ?? 0) / (value?.song?.duration ?? 1);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: nowPlayingSong,
      builder: (context, value, child) => Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: Theme.of(context).colorScheme.surface,
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.4)],
            stops: [percentage(value), percentage(value)],
          ),
        ),
        child: Row(children: [
          SizedBox.square(dimension: 64, child: Image.network(value?.song?.imageUrl ?? '', fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox())),
          const Gap(16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(value?.song?.title ?? '', style: Theme.of(context).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              const Gap(16),
              Text(value?.song?.artist ?? '', style: Theme.of(context).textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            ]),
          ),
        ]),
      ),
    );
  }
}
