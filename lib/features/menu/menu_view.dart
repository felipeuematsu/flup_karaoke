import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/features/menu/components/menu_tile.dart';
import 'package:flup_karaoke/router/app_router.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuTile(
          icon: const Icon(Icons.people),
          text: AppStrings.singersTitle.tr,
          onTap: () => context.pushRoute(SingersViewRoute(service: GetIt.I.get())),
        ),
        MenuTile(
          icon: const Icon(Icons.youtube_searched_for),
          text: AppStrings.youtubeSearchTitle.tr,
          onTap: () => context.pushRoute(YoutubeSearchViewRoute(service: GetIt.I.get())),
        ),
        MenuTile(
          icon: const Icon(Icons.playlist_add_circle),
          text: AppStrings.updatePlaylists.tr,
          onTap: () => service.updatePlaylists(),
        ),
      ],
    );
  }
}
