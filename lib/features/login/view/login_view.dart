import 'package:flup_karaoke/constants/mamiiranda.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/features/login/view/components/manual_connect_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<ServerRecord?> server = ValueNotifier(null);

  @override
  void initState() {
    Future.microtask(getLastServer);
    super.initState();
  }

  Future<void> getLastServer() async {
    final server = await database.serverRecords.where().sortByLastConnectedDesc().findFirst();
    this.server.value = server;
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).textTheme.titleSmall?.fontFamily);
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => toggleDarkMode(context).then((value) => setState(() {})),
          icon: ValueListenableBuilder(
              valueListenable: FlupKApp.of(context).isDarkMode,
              builder: (context, value, child) {
                if (value == true) {
                  return const Icon(Icons.light_mode);
                }
                return const Icon(Icons.dark_mode);
              }),
        ),
      ]),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: FittedBox(
              child: Text(
                FlupS.of(context).appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            flex: 3,
            child: Image.network('https://i.pinimg.com/originals/25/b3/e7/25b3e759186911d28bfac4bbad78ccca.gif', width: 300, fit: BoxFit.contain),
          ),
          _body(context),
          const Spacer(flex: 2),
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
      ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Container(
          color: Colors.black.withOpacity(0.08),
          padding: const EdgeInsets.all(16.0),
          child: Image.network(
            'https://cdn.icon-icons.com/icons2/2385/PNG/512/list_icon_144238.png',
            height: 32,
            width: 32,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 32),
      IconButton(
        color: Colors.black.withOpacity(0.08),
        onPressed: () {},
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/2313/2313147.png',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
          ),
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
          builder: (context, value, child) {
            return Column(children: [
              if (value != null) ...[
                FilledButton(
                  onPressed: () {},
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
            ]);
          },
        ),
      ),
    );
  }
}
