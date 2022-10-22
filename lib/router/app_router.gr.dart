// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    ServerSelectViewRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ServerSelectViewRouteArgs>(
          orElse: () =>
              ServerSelectViewRouteArgs(host: queryParams.optString('host')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ServerSelectView(
          key: args.key,
          host: args.host,
        ),
      );
    },
    MainViewRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<MainViewRouteArgs>(
          orElse: () => MainViewRouteArgs(host: queryParams.optString('host')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MainView(
          key: args.key,
          host: args.host,
        ),
      );
    },
    HomeViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    SearchViewRoute.name: (routeData) {
      final args = routeData.argsAs<SearchViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SearchView(
          key: args.key,
          service: args.service,
        ),
      );
    },
    QueueViewRoute.name: (routeData) {
      final args = routeData.argsAs<QueueViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: QueueView(
          key: args.key,
          service: args.service,
        ),
      );
    },
    MenuViewRoute.name: (routeData) {
      final args = routeData.argsAs<MenuViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MenuView(
          key: args.key,
          service: args.service,
        ),
      );
    },
    PlaylistViewRoute.name: (routeData) {
      final args = routeData.argsAs<PlaylistViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PlaylistView(
          key: args.key,
          id: args.id,
          service: args.service,
          getDetailedPlaylistUseCase: args.getDetailedPlaylistUseCase,
        ),
      );
    },
    SingersViewRoute.name: (routeData) {
      final args = routeData.argsAs<SingersViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SingersView(
          key: args.key,
          service: args.service,
        ),
      );
    },
    YoutubeSearchViewRoute.name: (routeData) {
      final args = routeData.argsAs<YoutubeSearchViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: YoutubeSearchView(
          key: args.key,
          service: args.service,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          ServerSelectViewRoute.name,
          path: '/',
        ),
        RouteConfig(
          MainViewRoute.name,
          path: '/',
          children: [
            RouteConfig(
              HomeViewRoute.name,
              path: '',
              parent: MainViewRoute.name,
              children: [
                RouteConfig(
                  PlaylistViewRoute.name,
                  path: 'playlist/:id',
                  parent: HomeViewRoute.name,
                )
              ],
            ),
            RouteConfig(
              SearchViewRoute.name,
              path: 'search-view',
              parent: MainViewRoute.name,
            ),
            RouteConfig(
              QueueViewRoute.name,
              path: 'queue-view',
              parent: MainViewRoute.name,
            ),
            RouteConfig(
              MenuViewRoute.name,
              path: 'menu-view',
              parent: MainViewRoute.name,
              children: [
                RouteConfig(
                  SingersViewRoute.name,
                  path: 'singers-view',
                  parent: MenuViewRoute.name,
                ),
                RouteConfig(
                  YoutubeSearchViewRoute.name,
                  path: 'youtube-search-view',
                  parent: MenuViewRoute.name,
                ),
                RouteConfig(
                  SingersViewRoute.name,
                  path: 'singers-view',
                  parent: MenuViewRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [ServerSelectView]
class ServerSelectViewRoute extends PageRouteInfo<ServerSelectViewRouteArgs> {
  ServerSelectViewRoute({
    Key? key,
    String? host,
  }) : super(
          ServerSelectViewRoute.name,
          path: '/',
          args: ServerSelectViewRouteArgs(
            key: key,
            host: host,
          ),
          rawQueryParams: {'host': host},
        );

  static const String name = 'ServerSelectViewRoute';
}

class ServerSelectViewRouteArgs {
  const ServerSelectViewRouteArgs({
    this.key,
    this.host,
  });

  final Key? key;

  final String? host;

  @override
  String toString() {
    return 'ServerSelectViewRouteArgs{key: $key, host: $host}';
  }
}

/// generated route for
/// [MainView]
class MainViewRoute extends PageRouteInfo<MainViewRouteArgs> {
  MainViewRoute({
    Key? key,
    String? host,
    List<PageRouteInfo>? children,
  }) : super(
          MainViewRoute.name,
          path: '/',
          args: MainViewRouteArgs(
            key: key,
            host: host,
          ),
          rawQueryParams: {'host': host},
          initialChildren: children,
        );

  static const String name = 'MainViewRoute';
}

class MainViewRouteArgs {
  const MainViewRouteArgs({
    this.key,
    this.host,
  });

  final Key? key;

  final String? host;

  @override
  String toString() {
    return 'MainViewRouteArgs{key: $key, host: $host}';
  }
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute({List<PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [SearchView]
class SearchViewRoute extends PageRouteInfo<SearchViewRouteArgs> {
  SearchViewRoute({
    Key? key,
    required KaraokeApiService service,
  }) : super(
          SearchViewRoute.name,
          path: 'search-view',
          args: SearchViewRouteArgs(
            key: key,
            service: service,
          ),
        );

  static const String name = 'SearchViewRoute';
}

class SearchViewRouteArgs {
  const SearchViewRouteArgs({
    this.key,
    required this.service,
  });

  final Key? key;

  final KaraokeApiService service;

  @override
  String toString() {
    return 'SearchViewRouteArgs{key: $key, service: $service}';
  }
}

/// generated route for
/// [QueueView]
class QueueViewRoute extends PageRouteInfo<QueueViewRouteArgs> {
  QueueViewRoute({
    Key? key,
    required KaraokeApiService service,
  }) : super(
          QueueViewRoute.name,
          path: 'queue-view',
          args: QueueViewRouteArgs(
            key: key,
            service: service,
          ),
        );

  static const String name = 'QueueViewRoute';
}

class QueueViewRouteArgs {
  const QueueViewRouteArgs({
    this.key,
    required this.service,
  });

  final Key? key;

  final KaraokeApiService service;

  @override
  String toString() {
    return 'QueueViewRouteArgs{key: $key, service: $service}';
  }
}

/// generated route for
/// [MenuView]
class MenuViewRoute extends PageRouteInfo<MenuViewRouteArgs> {
  MenuViewRoute({
    Key? key,
    required KaraokeApiService service,
    List<PageRouteInfo>? children,
  }) : super(
          MenuViewRoute.name,
          path: 'menu-view',
          args: MenuViewRouteArgs(
            key: key,
            service: service,
          ),
          initialChildren: children,
        );

  static const String name = 'MenuViewRoute';
}

class MenuViewRouteArgs {
  const MenuViewRouteArgs({
    this.key,
    required this.service,
  });

  final Key? key;

  final KaraokeApiService service;

  @override
  String toString() {
    return 'MenuViewRouteArgs{key: $key, service: $service}';
  }
}

/// generated route for
/// [PlaylistView]
class PlaylistViewRoute extends PageRouteInfo<PlaylistViewRouteArgs> {
  PlaylistViewRoute({
    Key? key,
    required int id,
    required KaraokeApiService service,
    required GetDetailedPlaylistUseCase getDetailedPlaylistUseCase,
  }) : super(
          PlaylistViewRoute.name,
          path: 'playlist/:id',
          args: PlaylistViewRouteArgs(
            key: key,
            id: id,
            service: service,
            getDetailedPlaylistUseCase: getDetailedPlaylistUseCase,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'PlaylistViewRoute';
}

class PlaylistViewRouteArgs {
  const PlaylistViewRouteArgs({
    this.key,
    required this.id,
    required this.service,
    required this.getDetailedPlaylistUseCase,
  });

  final Key? key;

  final int id;

  final KaraokeApiService service;

  final GetDetailedPlaylistUseCase getDetailedPlaylistUseCase;

  @override
  String toString() {
    return 'PlaylistViewRouteArgs{key: $key, id: $id, service: $service, getDetailedPlaylistUseCase: $getDetailedPlaylistUseCase}';
  }
}

/// generated route for
/// [SingersView]
class SingersViewRoute extends PageRouteInfo<SingersViewRouteArgs> {
  SingersViewRoute({
    Key? key,
    required KaraokeApiService service,
  }) : super(
          SingersViewRoute.name,
          path: 'singers-view',
          args: SingersViewRouteArgs(
            key: key,
            service: service,
          ),
        );

  static const String name = 'SingersViewRoute';
}

class SingersViewRouteArgs {
  const SingersViewRouteArgs({
    this.key,
    required this.service,
  });

  final Key? key;

  final KaraokeApiService service;

  @override
  String toString() {
    return 'SingersViewRouteArgs{key: $key, service: $service}';
  }
}

/// generated route for
/// [YoutubeSearchView]
class YoutubeSearchViewRoute extends PageRouteInfo<YoutubeSearchViewRouteArgs> {
  YoutubeSearchViewRoute({
    Key? key,
    required KaraokeApiService service,
  }) : super(
          YoutubeSearchViewRoute.name,
          path: 'youtube-search-view',
          args: YoutubeSearchViewRouteArgs(
            key: key,
            service: service,
          ),
        );

  static const String name = 'YoutubeSearchViewRoute';
}

class YoutubeSearchViewRouteArgs {
  const YoutubeSearchViewRouteArgs({
    this.key,
    required this.service,
  });

  final Key? key;

  final KaraokeApiService service;

  @override
  String toString() {
    return 'YoutubeSearchViewRouteArgs{key: $key, service: $service}';
  }
}
