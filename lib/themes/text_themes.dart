import 'package:flup_karaoke/generated/fonts.gen.dart';
import 'package:flup_karaoke/themes/color_schemes.g.dart';
import 'package:flutter/material.dart';

final lightTextTheme = Typography.whiteCupertino.apply(
  bodyColor: lightColorScheme.onBackground,
  displayColor: darkColorScheme.primary,
  fontFamily: FontFamily.poppins,
);
final darkTextTheme = Typography.blackCupertino.apply(
  bodyColor: darkColorScheme.onBackground,
  displayColor: darkColorScheme.primary,
  fontFamily: FontFamily.poppins,
);
