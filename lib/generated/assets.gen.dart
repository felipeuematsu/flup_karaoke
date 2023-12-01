/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFishGen {
  const $AssetsFishGen();

  /// File path: assets/fish/double.png
  AssetGenImage get double => const AssetGenImage('assets/fish/double.png');

  /// File path: assets/fish/happy.png
  AssetGenImage get happy => const AssetGenImage('assets/fish/happy.png');

  /// File path: assets/fish/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/fish/logo.png');

  /// File path: assets/fish/sad.png
  AssetGenImage get sad => const AssetGenImage('assets/fish/sad.png');

  /// File path: assets/fish/singing.png
  AssetGenImage get singing => const AssetGenImage('assets/fish/singing.png');

  /// File path: assets/fish/surprised.png
  AssetGenImage get surprised => const AssetGenImage('assets/fish/surprised.png');

  /// List of all assets
  List<AssetGenImage> get values => [double, happy, logo, sad, singing, surprised];
}

class Assets {
  Assets._();

  static const String appstoreButton = 'assets/appstore_button.svg';
  static const $AssetsFishGen fish = $AssetsFishGen();
  static const String playstoreButton = 'assets/playstore_button.svg';

  /// List of all assets
  List<String> get values => [appstoreButton, playstoreButton];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
