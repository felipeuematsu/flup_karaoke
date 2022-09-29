import 'package:flutter/material.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  MainView({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;
  final pageController = PageController();

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.appName.tr)),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: currentIndex, onTap: (index) => setState(() => widget.pageController.jumpToPage(index))),
      body: PageView(controller: widget.pageController, children: widget.children),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() => setState(() => currentIndex = widget.pageController.page!.round()));
  }
}
