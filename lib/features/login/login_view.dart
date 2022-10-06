import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/database/database.dart';
import 'package:karaoke_request_client/database/database_keys.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final hostController = TextEditingController();

  final database = Database();

  bool hasError = false;

  VoidCallback get onPressed => () {
        final service = KaraokeApiService(configuration: KaraokeAPIConfiguration(port: 8159, baseUrl: 'http://${hostController.text}'));
        try {
          service.getQueue().then((value) {
            database.writePersistent(DatabaseKeys.host.name, hostController.text);
            Get.delete<KaraokeApiService>(force: true);
            Get.lazyPut<KaraokeApiService>(() => service);
            return Navigator.of(context).popAndPushNamed(NavigationRoutes.home.route);
          });
        } catch (e) {
          setState(() => hasError = true);
          print(e);
        }
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.enterHost.tr, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: hostController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (_) => setState(() => hasError = false),
                  onSubmitted: (_) => onPressed(),
                ),
              ),
              if (hasError) const SizedBox(height: 16),
              if (hasError) Text(AppStrings.invalidHost.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(AppStrings.connect.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
