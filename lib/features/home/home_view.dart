import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/home/components/now_playing/now_playing_view.dart';
import 'package:karaoke_request_client/features/home/components/playlists_horizontal_scroll_view.dart';
import 'package:karaoke_request_client/features/widgets/custom_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentIndex: 0,
      body: Column(
        children: const [
          PlaylistsHorizontalScrollView(),
          Spacer(),
          NowPlayingView(),
        ],
      ),
    );
  }
}
