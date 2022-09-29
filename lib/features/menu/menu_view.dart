import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/menu/components/menu_tile.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key, required this.service}) : super(key: key);
  final KaraokeApiService service;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuTile(
          icon: const Icon(Icons.people),
          text: AppStrings.singersTitle.tr,
          onTap: () => Navigator.of(context).pushNamed(NavigationRoutes.singers.route),
        ),
      ],
    );
  }
}
