import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/features/search/controller/search_view_controller.dart';
import 'package:flup_karaoke/features/search/view/components/search_bar_component.dart';
import 'package:flup_karaoke/features/search/view/components/search_results_component.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewController controller = GetIt.I();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(centerTitle: false, title: const Text('Search'), actions: [
        IconButton(
          icon: const Icon(Icons.login),
          onPressed: () => AutoRouter.of(context).push(const LoginRoute()),
        ),
      ]),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(children: [
      SearchBarComponent(controller: controller),
      Expanded(child: SearchResultsComponent(controller: controller)),
    ]);
  }
}
