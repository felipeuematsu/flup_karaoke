import 'package:flup_karaoke/configurations/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenStoreWidget extends StatelessWidget {
  const OpenStoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (TargetPlatform.iOS != defaultTargetPlatform)
          InkWell(
            onTap: () => launchUrlString(googlePlayStoreUrl, mode: LaunchMode.externalApplication),
            child: SvgPicture.asset(TargetPlatform.android == defaultTargetPlatform ? androidPng : iOSSvg, height: 60, fit: BoxFit.fitHeight),
          ),
        // TODO: Add iOS store link
        // if (TargetPlatform.android != defaultTargetPlatform)
        //   InkWell(
        //     onTap: null,
        //     child: SvgPicture.asset(TargetPlatform.android == defaultTargetPlatform ? androidPng : iOSSvg, height: 60, fit: BoxFit.fitHeight),
        //   ),
      ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: e)).toList(),
    );
  }
}
