import 'package:flup_karaoke/generated/assets.gen.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flutter/material.dart';

enum FishAssetsMapper {
  happy,
  sad,
  singing,
  surprised,
  double,
  ;

  ColorScheme colorScheme(BuildContext context) {
    return switch (this) {
      FishAssetsMapper.happy => Theme.of(context).colorScheme.copyWith(
            surface: CustomColors.of(context).happyfishContainer,
            background: CustomColors.of(context).happyfishContainer,
            primary: CustomColors.of(context).happyfish,
            primaryContainer: CustomColors.of(context).happyfishContainer,
            onPrimary: CustomColors.of(context).onHappyfish,
            onPrimaryContainer: CustomColors.of(context).onHappyfishContainer,
          ),
      FishAssetsMapper.sad => Theme.of(context).colorScheme.copyWith(
            surface: CustomColors.of(context).sadfishlightContainer,
            background: CustomColors.of(context).sadfishlightContainer,
            primary: CustomColors.of(context).sadfishlight,
            primaryContainer: CustomColors.of(context).sadfishlightContainer,
            onPrimary: CustomColors.of(context).onSadfishlight,
            onPrimaryContainer: CustomColors.of(context).onSadfishlightContainer,
          ),
      FishAssetsMapper.singing => Theme.of(context).colorScheme.copyWith(
            surface: CustomColors.of(context).singingfishlightContainer,
            background: CustomColors.of(context).singingfishlightContainer,
            primary: CustomColors.of(context).singingfishlight,
            primaryContainer: CustomColors.of(context).singingfishlightContainer,
            onPrimary: CustomColors.of(context).onSingingfishlight,
            onPrimaryContainer: CustomColors.of(context).onSingingfishlightContainer,
          ),
      FishAssetsMapper.surprised => Theme.of(context).colorScheme.copyWith(
            surface: Theme.of(context).colorScheme.secondaryContainer,
            background: Theme.of(context).colorScheme.secondaryContainer,
            primary: Theme.of(context).colorScheme.secondary,
            primaryContainer: Theme.of(context).colorScheme.secondaryContainer,
            onPrimary: Theme.of(context).colorScheme.onSecondary,
            onPrimaryContainer: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
      FishAssetsMapper.double => Theme.of(context).colorScheme.copyWith(
            surface: CustomColors.of(context).twofishdetailContainer,
            background: CustomColors.of(context).twofishdetailContainer,
            primary: CustomColors.of(context).twofishdetail,
            primaryContainer: CustomColors.of(context).twofishdetailContainer,
            onPrimary: CustomColors.of(context).onTwofishdetail,
            onPrimaryContainer: CustomColors.of(context).onTwofishdetailContainer,
          ),
    };
  }

  AssetGenImage get icon {
    return switch (this) {
      FishAssetsMapper.happy => Assets.fish.happy,
      FishAssetsMapper.sad => Assets.fish.sad,
      FishAssetsMapper.singing => Assets.fish.singing,
      FishAssetsMapper.surprised => Assets.fish.surprised,
      FishAssetsMapper.double => Assets.fish.double,
    };
  }
}
