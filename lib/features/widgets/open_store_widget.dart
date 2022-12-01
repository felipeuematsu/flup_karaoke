import 'package:flup_karaoke/configurations/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenStoreWidget extends StatelessWidget {
  const OpenStoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => TargetPlatform.android == defaultTargetPlatform ? launchUrlString(googlePlayStoreUrl, mode: LaunchMode.externalApplication) : null,
      child: SvgPicture.asset(TargetPlatform.android == defaultTargetPlatform ? androidPng : iOSSvg, height: 60, fit: BoxFit.fitHeight),
    );
  }
}
