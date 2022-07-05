import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({Key? key, required this.body, required this.currentIndex}) : super(key: key);

  final int currentIndex;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName.tr),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: currentIndex),
      body: body,
    );
  }
}
