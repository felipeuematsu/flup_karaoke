import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/home_controller.dart';

class NowPlayingView extends GetView<HomeController> {
  const NowPlayingView({Key? key}) : super(key: key);

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
            child: Obx(() {
              final song = controller.nowPlayingSong?.song;
              final initialTime = controller.nowPlayingSong?.startTime;
              final singer = controller.nowPlayingSong?.singer;
              if (song == null || initialTime == null || singer == null) {
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
            }),
          ),
          Obx(() {
            final song = controller.nowPlayingSong;
            if (song != null) {
              return LinearProgressIndicator(
                value: controller.remainingTimePercentage,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
