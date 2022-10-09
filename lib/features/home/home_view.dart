import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/home/components/controller/home_controller_component.dart';
import 'package:karaoke_request_client/features/home/components/now_playing/now_playing_view.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_horizontal_scroll_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PlaylistsHorizontalScrollView(),
        // PlaylistsHorizontalScrollView(scrollItemType: ScrollItemType.artist),
        HomeControllerComponent(service: Get.find()),
        const Spacer(),
        const NowPlayingView(),
      ],
    );
  }
}
