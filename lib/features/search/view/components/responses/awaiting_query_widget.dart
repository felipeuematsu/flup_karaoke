import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/fish_assets.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AwaitingQueryWidget extends StatelessWidget {
  const AwaitingQueryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const fish = FishAssets.happy;
    final colorScheme = fish.colorScheme(context, Theme.of(context).colorScheme, CustomColors.of(context));
    return Column(mainAxisSize: MainAxisSize.min, children: [
      fish.icon.image(fit: BoxFit.contain),
      const Gap(16),
      Text(
        FlupS.of(context).awaitingQueryDescription,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: colorScheme.primary),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
