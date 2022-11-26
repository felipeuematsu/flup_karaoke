import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/home/controller/now_playing_song_controller.dart';
import 'package:flutter/material.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({Key? key, required this.controller}) : super(key: key);

  final NowPlayingSongController controller;

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 80),
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(AppStrings.nowPlayingTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.secondary)),
          ),
          Expanded(
            child: StreamBuilder(
              stream: widget.controller.nowPlayingSongStream,
              builder: (context, snapshot) {
                final songModel = snapshot.data;

                final song = songModel?.song;
                final singer = songModel?.singer;

                if (song == null || songModel?.position == null || singer == null) {
                  return Center(child: Text(AppStrings.nowPlayingEmpty.tr));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(song.artist ?? '', style: Theme.of(context).textTheme.titleSmall),
                            Text(song.title ?? '', style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        Text(singer, style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          StreamBuilder(
            stream: widget.controller.remainingTimePercentage,
            builder: (context, snapshot) {
              final percentage = snapshot.data;
              if (percentage == null) {
                return const SizedBox.shrink();
              } else {
                return LinearProgressIndicator(
                  value: percentage,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
