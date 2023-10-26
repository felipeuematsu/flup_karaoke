import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/fish_assets.dart';
import 'package:flutter/material.dart';

class NoItemsFoundWidget extends StatelessWidget {
  const NoItemsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,children: [
      FishAssets.sad.icon.image(fit: BoxFit.contain),
      const SizedBox(height: 16),
      Text(FlupS.of(context).noItemsFound, style: Theme.of(context).textTheme.labelMedium),
    ]);
  }
}
