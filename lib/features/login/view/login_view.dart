import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/constants/mamiiranda.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/features/login/view/components/manual_connect_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/assets_mapper.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<ServerRecord?> server = ValueNotifier(null);

  final db = AppDB.get();

  final randomFish = (FishAssetsMapper.values.toList()..shuffle()).first;

  @override
  void initState() {
    Future.microtask(getLastServer);
    super.initState();
  }

  Future<void> getLastServer() async {
    final server = await db.isar.serverRecords.where().sortByLastConnectedDesc().findFirst();
    this.server.value = server;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(colorScheme: randomFish.colorScheme(context)),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
          appBar: AppBar(backgroundColor: Colors.transparent, actions: [
            IconButton(
              onPressed: () => db.toggleDarkMode(context),
              icon: ValueListenableBuilder(
                valueListenable: FlupKApp.of(context).darkMode,
                builder: (context, value, child) => value == true ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
              ),
            ),
          ]),
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: FittedBox(
                  child: Text(
                    FlupS.of(context).appName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: randomFish.icon.image(fit: BoxFit.contain),
                ),
              ),
              Expanded(flex: 4, child: _body(context)),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(style: Theme.of(context).textTheme.labelSmall, children: [
                  TextSpan(text: FlupS.of(context).artBy),
                  TextSpan(
                    text: mamiirandaName,
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () => launchUrlString(linktreeUrl),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
            ]),
          ),
        );
      }),
    );
  }

  Widget _body(BuildContext context) {
    final newServerButton = TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => ManualConnectDialog(controller: LoginController()),
      ),
      child: Text(FlupS.of(context).insertNewServer),
    );
    final optionsRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        padding: EdgeInsets.zero,
        color: Colors.black.withOpacity(0.08),
        onPressed: () {},
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: BorderRadius.circular(99),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Image.network('https://cdn.icon-icons.com/icons2/2385/PNG/512/list_icon_144238.png', height: 32, width: 32, fit: BoxFit.cover),
        ),
      ),
      const SizedBox(width: 64),
      IconButton(
        padding: EdgeInsets.zero,
        color: Colors.black.withOpacity(0.08),
        onPressed: () {},
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: BorderRadius.circular(99),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Image.network('https://cdn-icons-png.flaticon.com/512/2313/2313147.png', height: 32, width: 32, fit: BoxFit.cover),
        ),
      ),
    ]);
    return Card(
      margin: const EdgeInsets.all(32.0),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(32.0),
        child: ValueListenableBuilder(
          valueListenable: server,
          builder: (context, value, child) => Column(children: [
            if (value != null) ...[
              FilledButton(
                onPressed: () => _goToHome(value),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text(value.name ?? ''),
                    Text(value.ip ?? ''),
                  ]),
                ),
              ),
              const SizedBox(height: 32),
            ],
            newServerButton,
            const SizedBox(height: 32),
            optionsRow,
          ]),
        ),
      ),
    );
  }

  void _goToHome(ServerRecord server) {
    db.isar.serverRecords.put(server);
    db.setCurrentServer(server);
    final ip = server.ip;
    if (ip != null) {
      GetIt.I.registerSingleton(KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: ip)));
      AutoRouter.of(context).replaceAll([const HomeRoute()]);
    }
  }
}
