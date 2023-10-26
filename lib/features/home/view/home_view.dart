import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Center(child: Text('Home')),
          const SizedBox(height: 32),

          ElevatedButton(onPressed: () => AutoRouter.of(context).push(const SearchRoute()), child: const Text('Search')),
        ],
      ),
    );
  }
}
