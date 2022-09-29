import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/home/components/now_playing/now_playing_view.dart';
import 'package:karaoke_request_client/features/home/components/playlists/playlists_horizontal_scroll_view.dart';
import 'package:karaoke_request_client/features/home/components/playlists/scroll_item_type.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PlaylistsHorizontalScrollView(scrollItemType: ScrollItemType.playlist),
        PlaylistsHorizontalScrollView(scrollItemType: ScrollItemType.artist),
        Spacer(),
        NowPlayingView(),
      ],
    );
  }
}
