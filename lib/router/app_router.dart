import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/home/home_view.dart';
import 'package:karaoke_request_client/features/home/use_case/get_complete_playlist.dart';
import 'package:karaoke_request_client/features/login/server_select_view.dart';
import 'package:karaoke_request_client/features/menu/menu_view.dart';
import 'package:karaoke_request_client/features/playlist/playlist_view.dart';
import 'package:karaoke_request_client/features/queue/queue_view.dart';
import 'package:karaoke_request_client/features/search/components/search_view.dart';
import 'package:karaoke_request_client/features/singers/singers_view.dart';
import 'package:karaoke_request_client/features/widgets/main_view.dart';
import 'package:karaoke_request_client/features/youtube_search/youtube_search_view.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,View',
  routes: <AutoRoute>[
    AutoRoute(page: ServerSelectView, initial: true),
    AutoRoute(page: MainView, path: '/', children: [
      AutoRoute(page: HomeView, initial: true, children: [
        AutoRoute(page: PlaylistView, path: 'playlist/:id'),
      ]),
      AutoRoute(page: SearchView),
      AutoRoute(page: QueueView),
      AutoRoute(page: MenuView, children: [
        AutoRoute(page: SingersView),
        AutoRoute(page: YoutubeSearchView),
        AutoRoute(page: SingersView),
      ]),
    ]),
  ],
)
class AppRouter extends _$AppRouter {}
