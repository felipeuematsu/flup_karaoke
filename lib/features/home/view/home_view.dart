import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/configuration/constants.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/home/view/components/home_grid_tile.dart';
import 'package:flup_karaoke/features/mini_player/view/mini_player_view.dart';
import 'package:flup_karaoke/features/now_playing/controller/mini_player_controller.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final NowPlayingController miniPlayerController;

  late final animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

  late final timer = Timer.periodic(
    const Duration(seconds: 1),
    (_) => GetIt.I<KaraokeApiService>()
        .getNowPlayingSong()
        .then((value) => miniPlayerController.nowPlayingSong.value = value)
        .onError((error, stackTrace) => null),
  );

  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<NowPlayingController>()) {
      logout(context);
    }
    miniPlayerController = GetIt.I();
    miniPlayerController.nowPlayingSong.addListener(animationListener);
  }

  void animationListener() {
    if (miniPlayerController.nowPlayingSong.value == null) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    animationController.dispose();
    miniPlayerController.nowPlayingSong.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).home), centerTitle: false, actions: [
        if (isMockOn)
          IconButton(
            icon: const Icon(Icons.accessibility),
            onPressed: () {
              if (animationController.isCompleted) {
                animationController.reverse();
              } else {
                animationController.forward();
              }
            },
          ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: FlupKApp.of(context).setNextFish,
        ),
        IconButton(
          onPressed: () => AppDB.get().toggleDarkMode(context),
          icon: ValueListenableBuilder(
            valueListenable: FlupKApp.of(context).darkMode,
            builder: (context, value, child) => value == true ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(context),
        ),
      ]),
      body: Stack(children: [
        Positioned.fill(
          child: Column(children: [
            Builder(builder: (context) {
              final width = MediaQuery.of(context).size.width;
              final height = MediaQuery.of(context).size.height;
              final boxWidth = width / 2 > height / 4 ? height / 3.5 * 2 : width;

              return SizedBox(
                width: boxWidth,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
                  children: [
                    HomeGridTile(title: FlupS.of(context).search, icon: Icons.search, route: const SearchRoute()),
                    HomeGridTile(title: FlupS.of(context).playlists, icon: Icons.music_note, route: const AllPlaylistsRoute()),
                    HomeGridTile(title: FlupS.of(context).nowPlaying, icon: Icons.play_arrow, route: const NowPlayingRoute()),
                    HomeGridTile(title: FlupS.of(context).profileMenu, icon: Icons.menu, route: const ProfileMenuRoute()),
                  ],
                ),
              );
            }),
            const Spacer(),
            ValueListenableBuilder(valueListenable: FlupKApp.of(context).currentFish, builder: (_, value, __) => value.icon.image()),
            const Spacer(flex: 2),
          ]),
        ),
        Builder(builder: (context) {
          const miniPlayerView = MiniPlayerView();
          return Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: miniPlayerView.preferredSize.height,
            child: AnimatedBuilder(
              animation: animationController,
              child: miniPlayerView,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, miniPlayerView.preferredSize.height * (1 - animationController.value)),
                child: child,
              ),
            ),
          );
        }),
      ]),
    );
  }
}
