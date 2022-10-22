import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/app_imports.dart';
import 'package:karaoke_request_client/database/database.dart';
import 'package:karaoke_request_client/database/database_keys.dart';
import 'package:karaoke_request_client/router/app_router.dart';

class ServerSelectView extends StatefulWidget {
  const ServerSelectView({Key? key, @QueryParam() this.host}) : super(key: key);

  final String? host;

  @override
  State<ServerSelectView> createState() => _ServerSelectViewState();
}

class _ServerSelectViewState extends State<ServerSelectView> {
  final hostController = TextEditingController();

  final database = Database();

  bool hasError = false;

  VoidCallback get onPressed => () {
        final uri = Uri.tryParse(hostController.text.trim());
        final service = KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: 'https://${uri?.host}'));

        service.getQueue().then((value) {
          database.writePersistent(DatabaseKeys.host.name, hostController.text);
          GetIt.I.registerLazySingleton(() => service);
          return context.replaceRoute(const HomeViewRoute());
        }).onError((error, stackTrace) => setState(() => hasError = true));
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
