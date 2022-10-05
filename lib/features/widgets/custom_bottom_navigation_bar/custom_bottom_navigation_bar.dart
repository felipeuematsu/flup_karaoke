import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/app_strings.dart';

enum NavigationRoutes {
  home('/'),
  singers('/singers'),
  youtubeSearch('/youtube-search'),
  login('/login'),
  ;

  const NavigationRoutes(this.route);

  final String route;
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  final int currentIndex;
  final Function(int) onTap;

  BottomNavigationBarItem _item(IconData icon, String title) => BottomNavigationBarItem(icon: Icon(icon), label: title);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      onTap: (index) => onTap(index),
      items: [
        _item(Icons.home, AppStrings.navButtonHome.tr),
        _item(Icons.search, AppStrings.navButtonSearch.tr),
        _item(Icons.queue_music, AppStrings.navButtonQueue.tr),
        _item(Icons.settings, AppStrings.navButtonSettings.tr),
      ],
    );
  }
}
