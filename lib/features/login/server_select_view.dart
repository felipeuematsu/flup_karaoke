import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/database_keys.dart';
import 'package:flup_karaoke/features/widgets/open_store_widget.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flup_karaoke/util/host_checker_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

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

  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<KaraokeApiService>()) GetIt.I.unregister<KaraokeApiService>();
  }

  VoidCallback get onPressed => () async {
        final input = hostController.text.trim();
        final uris = [testHttpHost(input), testHttpsHost(input)];
        for (final uri in uris) {
          final service = KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: uri.toString()));
          if (!await service.health()) continue;

          database.writePersistent(DatabaseKeys.host.name, input);
          GetIt.I.registerLazySingleton(() => service);
          return context.router.replaceAll([const MainViewRoute()]);
        }
        setState(() => hasError = true);
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
              const Spacer(),
              Text(AppStrings.enterHost.tr, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: hostController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.send,
                  textAlign: TextAlign.center,
                  onChanged: (_) => setState(() => hasError = false),
                  onSubmitted: (_) => onPressed(),
                ),
              ),
              if (hasError) const SizedBox(height: 16),
              if (hasError) Text(AppStrings.invalidHost.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onPressed, child: Text(AppStrings.connect.tr)),
              const SizedBox(height: 16),
              // if (kIsWeb &&
              //     [
              //       TargetPlatform.android, /*TargetPlatform.iOS*/
              //     ].contains(defaultTargetPlatform))
              ...[
                const Spacer(),
                const OpenStoreWidget(),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
