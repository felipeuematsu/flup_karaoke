import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/home/components/controller/controller_button.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class HomeControllerComponent extends StatelessWidget {
  const HomeControllerComponent({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2),
      children: [
        ControllerButton(onPressed: () => service.volumeUp(), text: AppStrings.volumeUp.tr, icon: const Icon(Icons.volume_up)),
        const SizedBox(),
        ControllerButton(onPressed: () => service.volumeDown(), text: AppStrings.volumeDown.tr, icon: const Icon(Icons.volume_down)),
        const SizedBox(),
        ControllerButton(onPressed: () => service.play(), text: AppStrings.playButton.tr, icon: const Icon(Icons.play_arrow)),
        const SizedBox(),
        ControllerButton(onPressed: () => service.pause(), text: AppStrings.pauseButton.tr, icon: const Icon(Icons.pause)),
        const SizedBox(),
        ControllerButton(onPressed: () => service.skip(), text: AppStrings.skipButton.tr, icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
