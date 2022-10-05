import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final service = Get.find<KaraokeApiService?>();
    if (service == null) {
      return RouteSettings(name: NavigationRoutes.login.route);
    }
    return null;
  }
}
