import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/nav2/get_router_delegate.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/home_view.dart';
import 'package:karaoke_request_client/features/menu/menu_view.dart';
import 'package:karaoke_request_client/features/queue/queue_view.dart';
import 'package:karaoke_request_client/features/search/components/search_view.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  MainView({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;
  final pageController = PageController();

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(NavigationRoutes.login.route, (route) => false),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: currentIndex, onTap: (index) => setState(() => widget.pageController.jumpToPage(index))),
      body: PageView(
        controller: widget.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeView(),
          SearchView(service: widget.service),
          QueueView(service: widget.service),
          MenuView(service: widget.service),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() => setState(() => currentIndex = widget.pageController.page!.round()));
  }
}
