import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/components/controller/home_controller_component.dart';
import 'package:karaoke_request_client/features/home/components/now_playing/now_playing_view.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_horizontal_scroll_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaylistsHorizontalScrollView(title: AppStrings.playlistsTitle.tr, playlistsController: GetIt.I.get()),
        HomeControllerComponent(service: GetIt.I.get()),
        const Spacer(),
        NowPlayingView(controller: GetIt.I.get()),
      ],
    );
  }
}
