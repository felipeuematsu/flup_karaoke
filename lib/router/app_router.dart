import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
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

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,View',
  routes: <AutoRoute>[
    CustomRoute(page: ServerSelectView, transitionsBuilder: TransitionsBuilders.noTransition),
    AutoRoute(page: PlaylistView, path: 'playlist/:id', guards: [ServiceGuard]),
    AutoRoute(page: MainView, path: '', initial: true, children: [
      AutoRoute(page: HomeView, initial: true, children: [], guards: [ServiceGuard]),
      AutoRoute(page: SearchView, guards: [ServiceGuard]),
      AutoRoute(page: QueueView, guards: [ServiceGuard]),
      AutoRoute(page: MenuView, guards: [ServiceGuard]),
    ], guards: [
      ServiceGuard
    ]),
    AutoRoute(page: SingersView, guards: [ServiceGuard]),
    AutoRoute(page: YoutubeSearchView, guards: [ServiceGuard]),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required super.serviceGuard});
}
