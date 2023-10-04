import 'package:flup_karaoke/themes/color_schemes.g.dart';
import 'package:flutter/material.dart';

// Create a textTheme using Poppins font
final lightTextTheme = Typography.whiteCupertino.apply(bodyColor: lightColorScheme.onBackground, displayColor: darkColorScheme.primary, fontFamily: 'Poppins');
final darkTextTheme = Typography.blackCupertino.apply(bodyColor: darkColorScheme.onBackground, displayColor: darkColorScheme.primary, fontFamily: 'Poppins');
