import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const lightpink = Color(0xFF96439D);
const purple = Color(0xFF390164);
const lightgreen = Color(0xFFCDF5DB);

CustomColors lightCustomColors = const CustomColors._(
  sourceLightpink: Color(0xFF96439D),
  lightpink: Color(0xFF8F3C96),
  onLightpink: Color(0xFFFFFFFF),
  lightpinkContainer: Color(0xFFFFD6FB),
  onLightpinkContainer: Color(0xFF36003D),
  sourcePurple: Color(0xFF390164),
  purple: Color(0xFF7749A2),
  onPurple: Color(0xFFFFFFFF),
  purpleContainer: Color(0xFFF0DBFF),
  onPurpleContainer: Color(0xFF2C0050),
  sourceLightgreen: Color(0xFFCDF5DB),
  lightgreen: Color(0xFF006C46),
  onLightgreen: Color(0xFFFFFFFF),
  lightgreenContainer: Color(0xFF8FF7C0),
  onLightgreenContainer: Color(0xFF002112),
);

CustomColors darkCustomColors = const CustomColors._(
  sourceLightpink: Color(0xFF96439D),
  lightpink: Color(0xFFFEA9FF),
  onLightpink: Color(0xFF580063),
  lightpinkContainer: Color(0xFF73227C),
  onLightpinkContainer: Color(0xFFFFD6FB),
  sourcePurple: Color(0xFF390164),
  purple: Color(0xFFDEB7FF),
  onPurple: Color(0xFF461570),
  purpleContainer: Color(0xFF5E3089),
  onPurpleContainer: Color(0xFFF0DBFF),
  sourceLightgreen: Color(0xFFCDF5DB),
  lightgreen: Color(0xFF72DAA5),
  onLightgreen: Color(0xFF003822),
  lightgreenContainer: Color(0xFF005234),
  onLightgreenContainer: Color(0xFF8FF7C0),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  static CustomColors of(BuildContext context) => Theme.of(context).extension<CustomColors>()!;

  const CustomColors._({
    required this.sourceLightpink,
    required this.lightpink,
    required this.onLightpink,
    required this.lightpinkContainer,
    required this.onLightpinkContainer,
    required this.sourcePurple,
    required this.purple,
    required this.onPurple,
    required this.purpleContainer,
    required this.onPurpleContainer,
    required this.sourceLightgreen,
    required this.lightgreen,
    required this.onLightgreen,
    required this.lightgreenContainer,
    required this.onLightgreenContainer,
  });

  final Color? sourceLightpink;
  final Color? lightpink;
  final Color? onLightpink;
  final Color? lightpinkContainer;
  final Color? onLightpinkContainer;
  final Color? sourcePurple;
  final Color? purple;
  final Color? onPurple;
  final Color? purpleContainer;
  final Color? onPurpleContainer;
  final Color? sourceLightgreen;
  final Color? lightgreen;
  final Color? onLightgreen;
  final Color? lightgreenContainer;
  final Color? onLightgreenContainer;

  @override
  CustomColors copyWith({
    Color? sourceLightpink,
    Color? lightpink,
    Color? onLightpink,
    Color? lightpinkContainer,
    Color? onLightpinkContainer,
    Color? sourcePurple,
    Color? purple,
    Color? onPurple,
    Color? purpleContainer,
    Color? onPurpleContainer,
    Color? sourceLightgreen,
    Color? lightgreen,
    Color? onLightgreen,
    Color? lightgreenContainer,
    Color? onLightgreenContainer,
  }) {
    return CustomColors._(
      sourceLightpink: sourceLightpink ?? this.sourceLightpink,
      lightpink: lightpink ?? this.lightpink,
      onLightpink: onLightpink ?? this.onLightpink,
      lightpinkContainer: lightpinkContainer ?? this.lightpinkContainer,
      onLightpinkContainer: onLightpinkContainer ?? this.onLightpinkContainer,
      sourcePurple: sourcePurple ?? this.sourcePurple,
      purple: purple ?? this.purple,
      onPurple: onPurple ?? this.onPurple,
      purpleContainer: purpleContainer ?? this.purpleContainer,
      onPurpleContainer: onPurpleContainer ?? this.onPurpleContainer,
      sourceLightgreen: sourceLightgreen ?? this.sourceLightgreen,
      lightgreen: lightgreen ?? this.lightgreen,
      onLightgreen: onLightgreen ?? this.onLightgreen,
      lightgreenContainer: lightgreenContainer ?? this.lightgreenContainer,
      onLightgreenContainer: onLightgreenContainer ?? this.onLightgreenContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors._(
      sourceLightpink: Color.lerp(sourceLightpink, other.sourceLightpink, t),
      lightpink: Color.lerp(lightpink, other.lightpink, t),
      onLightpink: Color.lerp(onLightpink, other.onLightpink, t),
      lightpinkContainer: Color.lerp(lightpinkContainer, other.lightpinkContainer, t),
      onLightpinkContainer: Color.lerp(onLightpinkContainer, other.onLightpinkContainer, t),
      sourcePurple: Color.lerp(sourcePurple, other.sourcePurple, t),
      purple: Color.lerp(purple, other.purple, t),
      onPurple: Color.lerp(onPurple, other.onPurple, t),
      purpleContainer: Color.lerp(purpleContainer, other.purpleContainer, t),
      onPurpleContainer: Color.lerp(onPurpleContainer, other.onPurpleContainer, t),
      sourceLightgreen: Color.lerp(sourceLightgreen, other.sourceLightgreen, t),
      lightgreen: Color.lerp(lightgreen, other.lightgreen, t),
      onLightgreen: Color.lerp(onLightgreen, other.onLightgreen, t),
      lightgreenContainer: Color.lerp(lightgreenContainer, other.lightgreenContainer, t),
      onLightgreenContainer: Color.lerp(onLightgreenContainer, other.onLightgreenContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceLightpink]
  ///   * [CustomColors.lightpink]
  ///   * [CustomColors.onLightpink]
  ///   * [CustomColors.lightpinkContainer]
  ///   * [CustomColors.onLightpinkContainer]
  ///   * [CustomColors.sourcePurple]
  ///   * [CustomColors.purple]
  ///   * [CustomColors.onPurple]
  ///   * [CustomColors.purpleContainer]
  ///   * [CustomColors.onPurpleContainer]
  ///   * [CustomColors.sourceLightgreen]
  ///   * [CustomColors.lightgreen]
  ///   * [CustomColors.onLightgreen]
  ///   * [CustomColors.lightgreenContainer]
  ///   * [CustomColors.onLightgreenContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceLightpink: sourceLightpink!.harmonizeWith(dynamic.primary),
      lightpink: lightpink!.harmonizeWith(dynamic.primary),
      onLightpink: onLightpink!.harmonizeWith(dynamic.primary),
      lightpinkContainer: lightpinkContainer!.harmonizeWith(dynamic.primary),
      onLightpinkContainer: onLightpinkContainer!.harmonizeWith(dynamic.primary),
      sourcePurple: sourcePurple!.harmonizeWith(dynamic.primary),
      purple: purple!.harmonizeWith(dynamic.primary),
      onPurple: onPurple!.harmonizeWith(dynamic.primary),
      purpleContainer: purpleContainer!.harmonizeWith(dynamic.primary),
      onPurpleContainer: onPurpleContainer!.harmonizeWith(dynamic.primary),
      sourceLightgreen: sourceLightgreen!.harmonizeWith(dynamic.primary),
      lightgreen: lightgreen!.harmonizeWith(dynamic.primary),
      onLightgreen: onLightgreen!.harmonizeWith(dynamic.primary),
      lightgreenContainer: lightgreenContainer!.harmonizeWith(dynamic.primary),
      onLightgreenContainer: onLightgreenContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
