import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/home/components/controller/home_controller_component.dart';
import 'package:flup_karaoke/features/home/components/now_playing/now_playing_view.dart';
import 'package:flup_karaoke/features/home/components/playlists/playlists_horizontal_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => reassemble(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                PlaylistsHorizontalScrollView(title: AppStrings.playlistsTitle.tr, playlistsController: GetIt.I.get()),
                HomeControllerComponent(service: GetIt.I.get()),
              ],
            ),
          ),
          NowPlayingView(controller: GetIt.I.get()),
        ],
      ),
    );
  }
}
