import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/home/components/controller/controller_button.dart';

class HomeControllerComponent extends StatelessWidget {
  const HomeControllerComponent({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Spacer(),
                Expanded(child: ControllerButton(onPressed: () => service.volumeUp(), text: AppStrings.volumeUp.tr, icon: const Icon(Icons.volume_up))),
                const Spacer(),
                Expanded(child: ControllerButton(onPressed: () => service.volumeDown(), text: AppStrings.volumeDown.tr, icon: const Icon(Icons.volume_down))),
                // const Spacer(),
              ],
            ),
            Row(
              children: [
                // const Spacer(),
                const Spacer(),
                Expanded(child: ControllerButton(onPressed: () => service.play(), text: AppStrings.playButton.tr, icon: const Icon(Icons.play_arrow))),
                const Spacer(),
                // const Spacer(),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Spacer(),
                Expanded(child: ControllerButton(onPressed: () => service.pause(), text: AppStrings.pauseButton.tr, icon: const Icon(Icons.pause))),
                const Spacer(),
                Expanded(child: ControllerButton(onPressed: () => service.skip(), text: AppStrings.skipButton.tr, icon: const Icon(Icons.skip_next))),
                // const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
