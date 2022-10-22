import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/app_imports.dart';
import 'package:karaoke_request_client/database/database.dart';
import 'package:karaoke_request_client/database/database_keys.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:karaoke_request_client/router/app_router.dart';
import 'package:karaoke_request_client/util/host_checker_util.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, @QueryParam() this.host}) : super(key: key);

  final String? host;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  void initState() {
    if (GetIt.I.isRegistered<KaraokeApiService>()) {
      return super.initState();
    }
    Database().readPersistent<String?>(DatabaseKeys.host.name).then((value) {
      final host = testHosts([widget.host, value, if (kIsWeb) Uri.base.host]);

      if (host == null) {
        context.replaceRoute(ServerSelectViewRoute());
        return;
      }

      final configuration = KaraokeAPIConfiguration(port: 80, baseUrl: 'https://${host.host}');
      final service = KaraokeApiService(configuration: configuration);

      service.getQueue().then((_) => GetIt.I.registerLazySingleton(() => service)).onError((error, stackTrace) => context.replaceRoute(ServerSelectViewRoute()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      physics: const NeverScrollableScrollPhysics(),
      routes: [
        const HomeViewRoute(),
        SearchViewRoute(service: GetIt.I.get()),
        QueueViewRoute(service: GetIt.I.get()),
        MenuViewRoute(service: GetIt.I.get()),
      ],
      builder: (context, child, pageController) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.appName.tr),
            actions: [
              if (!kIsWeb)
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.router.replaceAll([ServerSelectViewRoute()]);
                  },
                )
            ],
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => setState(() => tabsRouter.setActiveIndex(index)),
          ),
          body: child,
        );
      },
    );
  }
}
