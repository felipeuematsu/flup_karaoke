import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/configuration/constants.dart';
import 'package:flup_karaoke/constants/mamiiranda.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/features/login/view/components/manual_connect_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/ip_helper.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flup_karaoke/mock/karaoke_api_service_mock.dart';
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
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(backgroundColor: Colors.transparent, actions: [
          if (isMockOn)
            IconButton(
              onPressed: () {
                GetIt.I.registerSingleton<KaraokeApiService>(KaraokeApiServiceMock());

                AutoRouter.of(context).replace(const HomeRoute());
              },
              icon: const Icon(Icons.home),
            ),
          IconButton(
            onPressed: FlupKApp.of(context).setNextFish,
            icon: const Icon(Icons.refresh),
          ),
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
                  style: theme.textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: FlupKApp.of(context).currentFish.icon.image(fit: BoxFit.contain),
              ),
            ),
            _body(context),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(style: theme.textTheme.labelSmall, children: [
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
    });
  }

  Widget _body(BuildContext context) {
    final newServerButton = TextButton(
      onPressed: () => showDialog(context: context, useSafeArea: true, builder: (context) => const ManualConnectDialog()),
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

  Future<void> _goToHome(ServerRecord server) async {
    final ip = server.ip;
    if (ip == null) return;

    final loginController = GetIt.I.get<LoginController>();
    final testHost = await loginController.testHost(ip);

    if (!testHost) return showCurrentServerError(server);
    db.isar.writeTxn(() => db.isar.serverRecords.put(server));
    db.setCurrentServer(server);
    final service = isMockOn ? KaraokeApiServiceMock() : KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: formatHost(ip)?.toString() ?? ip));
    GetIt.I.registerSingleton<KaraokeApiService>(service);
    AutoRouter.of(context).replaceAll([const HomeRoute()]);
  }

  void showCurrentServerError(ServerRecord server) {
    final snackBar = SnackBar(
      content: Text(
        FlupS.of(context).serverIsNotAvailable(server.name ?? ''),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onError),
      ),
      elevation: 8,
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
