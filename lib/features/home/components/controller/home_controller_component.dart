import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/components/controller/controller_button.dart';

class HomeControllerComponent extends StatelessWidget {
  const HomeControllerComponent({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: ControllerButton(onPressed: () => service.volumeUp(), text: AppStrings.volumeUp.tr, icon: const Icon(Icons.volume_up))),
              const Spacer(),
              Expanded(child: ControllerButton(onPressed: () => service.volumeDown(), text: AppStrings.volumeDown.tr, icon: const Icon(Icons.volume_down))),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Expanded(child: ControllerButton(onPressed: () => service.play(), text: AppStrings.playButton.tr, icon: const Icon(Icons.play_arrow))),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: ControllerButton(onPressed: () => service.pause(), text: AppStrings.pauseButton.tr, icon: const Icon(Icons.pause))),
              const Spacer(),
              Expanded(child: ControllerButton(onPressed: () => service.skip(), text: AppStrings.skipButton.tr, icon: const Icon(Icons.skip_next))),
            ],
          ),
        ],
      ),
    );
  }
}
