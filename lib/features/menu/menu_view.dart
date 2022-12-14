import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/features/menu/components/menu_tile.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuTile(
          icon: const Icon(Icons.people),
          text: AppStrings.singersTitle.tr(context),
          onTap: () => context.pushRoute(SingersViewRoute(service: GetIt.I.get())),
        ),
        MenuTile(
          icon: const Icon(Icons.youtube_searched_for),
          text: AppStrings.youtubeSearchTitle.tr(context),
          onTap: () => context.pushRoute(YoutubeSearchViewRoute(service: GetIt.I.get())),
        ),
        MenuTile(
          icon: const Icon(Icons.playlist_add_circle),
          text: AppStrings.updatePlaylists.tr(context),
          onTap: () => widget.service.updatePlaylists(),
        ),
        MenuTile(
          icon: const Icon(Icons.settings),
          text: AppStrings.settingsTitle.tr(context),
          onTap: () => context.pushRoute(const SettingsViewRoute()),
        ),
      ],
    );
  }
}
