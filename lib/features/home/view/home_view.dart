import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/features/home/view/components/home_grid_tile.dart';
import 'package:flup_karaoke/features/mini_player/controller/mini_player_controller.dart';
import 'package:flup_karaoke/features/mini_player/view/mini_player_view.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final MiniPlayerController miniPlayerController;

  late final animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<MiniPlayerController>()) {
      logout(context);
    }
    miniPlayerController = GetIt.I();
    miniPlayerController.nowPlayingSong.addListener(() {
      if (miniPlayerController.nowPlayingSong.value == null) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: false,actions: [
        IconButton(
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ]),
      body: Stack(children: [
        Positioned.fill(
          child: GridView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            children: [
              HomeGridTile(title: FlupS.of(context).search, icon: Icons.search, route: const SearchRoute()),
            ],
          ),
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
