import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/components/playlists_scroll_item.dart';
import 'package:karaoke_request_client/features/home/home_controller.dart';

class PlaylistsHorizontalScrollView extends GetView<HomeController> {
  const PlaylistsHorizontalScrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: Text(AppStrings.playlistsTitle.tr, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: controller.isLoading ? const NeverScrollableScrollPhysics() : null,
            child: Obx(() => Row(children: controller.playlistsWidgets)),
          ),
        ),
      ],
    );
  }
}
