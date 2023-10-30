import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/fish_assets.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flutter/material.dart';

class NoMoreItemsWidget extends StatelessWidget {
  const NoMoreItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const fish = FishAssets.double;
    final colorScheme = fish.colorScheme(context, Theme.of(context).colorScheme, CustomColors.of(context));
    return SizedBox(
      height: 128,
      child: Row(children: [
        const SizedBox(width: 16),
        fish.icon.image(fit: BoxFit.contain),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            FlupS.of(context).noMoreItems,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 16),
      ]),
    );
  }
}
