import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';

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
        _item(Icons.home, AppStrings.navButtonHome.tr(context)),
        _item(Icons.search, AppStrings.navButtonSearch.tr(context)),
        _item(Icons.queue_music, AppStrings.navButtonQueue.tr(context)),
        _item(Icons.settings, AppStrings.navButtonSettings.tr(context)),
      ],
    );
  }
}
