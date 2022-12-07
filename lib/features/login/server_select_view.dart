import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/database/database_keys.dart';
import 'package:flup_karaoke/features/widgets/open_store_widget.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flup_karaoke/util/host_checker_util.dart';
import 'package:flutter/foundation.dart';
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
  final _hostController = TextEditingController();

  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    DatabaseKeys.host.readPersistent<String?>().then((lastHost) {
      if (widget.host != null) {
        _hostController.text = widget.host!;
      } else if (lastHost != null) {
        _hostController.text = lastHost;
      }
    });
    if (GetIt.I.isRegistered<KaraokeApiService>()) GetIt.I.unregister<KaraokeApiService>();
  }

  VoidCallback get onPressed => () async {
        final input = _hostController.text.trim();
        final uris = [testHttpHost(input), testHttpsHost(input)];
        for (final uri in uris) {
          final service = KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: uri.toString()));
          final foundServer = await service.health();
          if (!foundServer) continue;

          DatabaseKeys.host.writePersistent(input);
          GetIt.I.registerLazySingleton(() => service);
          return context.router.replaceAll([const MainViewRoute()]);
        }
        setState(() => _hasError = true);
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
                  autofillHints: const [AutofillHints.url],
                  autofocus: true,
                  controller: _hostController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.send,
                  textAlign: TextAlign.center,
                  onChanged: (_) => setState(() => _hasError = false),
                  onSubmitted: (_) => onPressed(),
                ),
              ),
              if (_hasError) const SizedBox(height: 16),
              if (_hasError) Text(AppStrings.invalidHost.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onPressed, child: Text(AppStrings.connect.tr)),
              const SizedBox(height: 16),
              if (kIsWeb) ...[
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
