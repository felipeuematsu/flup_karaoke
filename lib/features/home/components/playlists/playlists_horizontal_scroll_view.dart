import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/home/components/playlists/scroll_item_type.dart';
import 'package:karaoke_request_client/features/home/home_controller.dart';

class PlaylistsHorizontalScrollView extends GetView<HomeController> {
  const PlaylistsHorizontalScrollView({Key? key, this.scrollItemType = ScrollItemType.playlist}) : super(key: key);

  final ScrollItemType scrollItemType;

  bool get isLoading => scrollItemType == ScrollItemType.playlist ? controller.playlistsAreLoading : controller.artistsAreLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: Text(scrollItemType.title, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
        ),
        SizedBox(
          width: double.infinity,
          child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: isLoading ? const NeverScrollableScrollPhysics() : null,
                child: Obx(() => Row(children: controller.playlistsWidgets(scrollItemType))),
              )),
        ),
      ],
    );
  }
}
