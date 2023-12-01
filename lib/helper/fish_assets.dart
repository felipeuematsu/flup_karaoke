import 'package:flup_karaoke/generated/assets.gen.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flutter/material.dart';

enum FishAssets {
  happy,
  sad,
  singing,
  surprised,
  double,
  ;

  ColorScheme colorScheme(BuildContext context, ColorScheme colorScheme, CustomColors customColors) {
    return switch (this) {
      FishAssets.happy => colorScheme.copyWith(
            surface: customColors.happyfishContainer,
            background: customColors.happyfishContainer,
            primary: customColors.happyfish,
            primaryContainer: customColors.happyfishContainer,
            onPrimary: customColors.onHappyfish,
            onPrimaryContainer: customColors.onHappyfishContainer,
          ),
      FishAssets.sad => colorScheme.copyWith(
            surface: customColors.sadfishlightContainer,
            background: customColors.sadfishlightContainer,
            primary: customColors.sadfishlight,
            primaryContainer: customColors.sadfishlightContainer,
            onPrimary: customColors.onSadfishlight,
            onPrimaryContainer: customColors.onSadfishlightContainer,
          ),
      FishAssets.singing => colorScheme.copyWith(
            surface: customColors.singingfishlightContainer,
            background: customColors.singingfishlightContainer,
            primary: customColors.singingfishlight,
            primaryContainer: customColors.singingfishlightContainer,
            onPrimary: customColors.onSingingfishlight,
            onPrimaryContainer: customColors.onSingingfishlightContainer,
          ),
      FishAssets.surprised => colorScheme.copyWith(
            surface: colorScheme.secondaryContainer,
            background: colorScheme.secondaryContainer,
            primary: colorScheme.secondary,
            primaryContainer: colorScheme.secondaryContainer,
            onPrimary: colorScheme.onSecondary,
            onPrimaryContainer: colorScheme.onSecondaryContainer,
          ),
      FishAssets.double => colorScheme.copyWith(
            surface: customColors.twofishdetailContainer,
            background: customColors.twofishdetailContainer,
            primary: customColors.twofishdetail,
            primaryContainer: customColors.twofishdetailContainer,
            onPrimary: customColors.onTwofishdetail,
            onPrimaryContainer: customColors.onTwofishdetailContainer,
          ),
    };
  }

  AssetGenImage get icon {
    return switch (this) {
      FishAssets.happy => Assets.fish.happy,
      FishAssets.sad => Assets.fish.sad,
      FishAssets.singing => Assets.fish.singing,
      FishAssets.surprised => Assets.fish.surprised,
      FishAssets.double => Assets.fish.double,
    };
  }
}
