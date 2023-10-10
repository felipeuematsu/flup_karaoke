import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/generated/assets.gen.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  final animationDuration = const Duration(milliseconds: 750);
  late final AnimationController controller = AnimationController(vsync: this, duration: animationDuration);

  final db = AppDB.get();

  @override
  void initState() {
    super.initState();
    redirect();
  }

  Future<void> redirect() async {
    await controller.forward();
    await Future.delayed(const Duration(milliseconds: 1000));
    final ip = db.currentServer?.ip;
    await controller.reverse();
    if (ip != null) {
      final LoginController loginController = GetIt.I.get();
      final testHost = await loginController.testHost(ip);
      if (testHost) {
        GetIt.I.registerSingleton(KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: ip)));
        return AutoRouter.of(context).replaceAll([const HomeRoute()]);
      }
    }
    AutoRouter.of(context).replaceAll([const LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.of(context).happyfishContainer,
      child: AnimatedBuilder(
        animation: controller,
        child: Assets.fish.happy.image(width: MediaQuery.of(context).size.width * 0.8),
        builder: (context, child) => Center(child: Opacity(opacity: pow(controller.value, 4.0).toDouble(), child: child)),
      ),
    );
  }
}
