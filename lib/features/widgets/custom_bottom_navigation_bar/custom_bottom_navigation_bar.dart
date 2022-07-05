import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_client/features/app_strings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  BottomNavigationBarItem _item(IconData icon, String title) => BottomNavigationBarItem(icon: Icon(icon), label: title);

  onTap(int index) {
    switch (index) {
      case 1:
        return Get.offAllNamed('/');
      case 2:
        return Get.offAllNamed('/');
      case 3:
        return Get.offAllNamed('/');
      case 0:
      default:
        return Get.offAllNamed('/');
    }
  }

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
        _item(Icons.person, AppStrings.navButtonProfile.tr),
        _item(Icons.settings, AppStrings.navButtonSettings.tr),
      ],
    );
  }
}
