// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flup_karaoke/features/home/view/home_view.dart' as _i2;
import 'package:flup_karaoke/features/login/view/login_view.dart' as _i3;
import 'package:flup_karaoke/features/now_playing/view/now_playing_view.dart'
    as _i4;
import 'package:flup_karaoke/features/playlist/view/all_playlists_view.dart'
    as _i1;
import 'package:flup_karaoke/features/playlist/view/playlist_details_view.dart'
    as _i5;
import 'package:flup_karaoke/features/profile_menu/view/profile_menu_view.dart'
    as _i6;
import 'package:flup_karaoke/features/queue/view/queue_view.dart' as _i7;
import 'package:flup_karaoke/features/search/view/search_view.dart' as _i8;
import 'package:flup_karaoke/features/splash/view/splash_view.dart' as _i9;
import 'package:flup_karaoke/features/youtube_search/view/youtube_search_view.dart'
    as _i10;
import 'package:flutter/material.dart' as _i12;
import 'package:karaoke_request_api/karaoke_request_api.dart' as _i13;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AllPlaylistsRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AllPlaylistsView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
      );
    },
    NowPlayingRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NowPlayingView(),
      );
    },
    PlaylistDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PlaylistDetailsRouteArgs>(
          orElse: () => PlaylistDetailsRouteArgs(id: pathParams.getInt('id')));
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PlaylistDetailsView(
          key: args.key,
          id: args.id,
          playlist: args.playlist,
        ),
      );
    },
    ProfileMenuRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileMenuView(),
      );
    },
    QueueRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.QueueView(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SearchView(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SplashView(),
      );
    },
    YoutubeSearchRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.YoutubeSearchView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AllPlaylistsView]
class AllPlaylistsRoute extends _i11.PageRouteInfo<void> {
  const AllPlaylistsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AllPlaylistsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllPlaylistsRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.NowPlayingView]
class NowPlayingRoute extends _i11.PageRouteInfo<void> {
  const NowPlayingRoute({List<_i11.PageRouteInfo>? children})
      : super(
          NowPlayingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NowPlayingRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PlaylistDetailsView]
class PlaylistDetailsRoute
    extends _i11.PageRouteInfo<PlaylistDetailsRouteArgs> {
  PlaylistDetailsRoute({
    _i12.Key? key,
    required int id,
    _i13.SimplePlaylistModel? playlist,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PlaylistDetailsRoute.name,
          args: PlaylistDetailsRouteArgs(
            key: key,
            id: id,
            playlist: playlist,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'PlaylistDetailsRoute';

  static const _i11.PageInfo<PlaylistDetailsRouteArgs> page =
      _i11.PageInfo<PlaylistDetailsRouteArgs>(name);
}

class PlaylistDetailsRouteArgs {
  const PlaylistDetailsRouteArgs({
    this.key,
    required this.id,
    this.playlist,
  });

  final _i12.Key? key;

  final int id;

  final _i13.SimplePlaylistModel? playlist;

  @override
  String toString() {
    return 'PlaylistDetailsRouteArgs{key: $key, id: $id, playlist: $playlist}';
  }
}

/// generated route for
/// [_i6.ProfileMenuView]
class ProfileMenuRoute extends _i11.PageRouteInfo<void> {
  const ProfileMenuRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileMenuRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.QueueView]
class QueueRoute extends _i11.PageRouteInfo<void> {
  const QueueRoute({List<_i11.PageRouteInfo>? children})
      : super(
          QueueRoute.name,
          initialChildren: children,
        );

  static const String name = 'QueueRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SearchView]
class SearchRoute extends _i11.PageRouteInfo<void> {
  const SearchRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SplashView]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.YoutubeSearchView]
class YoutubeSearchRoute extends _i11.PageRouteInfo<void> {
  const YoutubeSearchRoute({List<_i11.PageRouteInfo>? children})
      : super(
          YoutubeSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'YoutubeSearchRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
