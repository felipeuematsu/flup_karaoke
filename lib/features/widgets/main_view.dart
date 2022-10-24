import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_client/app_imports.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:karaoke_request_client/router/app_router.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  void initState() {
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
                  onPressed: () => context.router.replace(ServerSelectViewRoute()),
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
