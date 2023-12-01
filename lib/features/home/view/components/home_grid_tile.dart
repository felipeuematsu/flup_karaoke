import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({super.key, required this.title, required this.icon, required this.route});

  final String title;
  final IconData icon;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).push(route),
      child: Card(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 48),
          const Gap(16),
          Text(title, maxLines: 1, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
        ]),
      ),
    );
  }
}
