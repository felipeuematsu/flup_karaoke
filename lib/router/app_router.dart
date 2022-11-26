import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/home/home_view.dart';
import 'package:flup_karaoke/features/home/use_case/get_complete_playlist.dart';
import 'package:flup_karaoke/features/login/server_select_view.dart';
import 'package:flup_karaoke/features/menu/menu_view.dart';
import 'package:flup_karaoke/features/playlist/playlist_view.dart';
import 'package:flup_karaoke/features/queue/queue_view.dart';
import 'package:flup_karaoke/features/search/components/search_view.dart';
import 'package:flup_karaoke/features/singers/singers_view.dart';
import 'package:flup_karaoke/features/widgets/main_view.dart';
import 'package:flup_karaoke/features/youtube_search/youtube_search_view.dart';
import 'package:flup_karaoke/router/guards/service_guard.dart';
import 'package:flutter/widgets.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

part 'app_router.gr.dart';

const serviceGuard = [ServiceGuard];

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,View',
  routes: <AutoRoute>[
    CustomRoute(page: ServerSelectView, transitionsBuilder: TransitionsBuilders.noTransition),
    AutoRoute(page: PlaylistView, path: 'playlist/:id', guards: serviceGuard),
    AutoRoute(page: MainView, path: '/', initial: true, guards: serviceGuard, children: [
      AutoRoute(page: HomeView, initial: true, guards: serviceGuard),
      AutoRoute(page: SearchView, guards: serviceGuard),
      AutoRoute(page: QueueView, guards: serviceGuard),
      AutoRoute(page: MenuView, guards: serviceGuard)
    ]),
    AutoRoute(page: SingersView, guards: serviceGuard),
    AutoRoute(page: YoutubeSearchView, guards: serviceGuard),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required super.serviceGuard});
}
