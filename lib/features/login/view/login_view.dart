import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/features/login/view/components/manual_connect_dialog.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FittedBox(
                child: Text(
                  FlupS.of(context).appName,
                  style: const TextStyle(fontSize: 128, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const Spacer(),
            _centerBody(context),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _centerBody(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(32.0),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(32.0),
        child: Column(children: [
          FilledButton(
            onPressed: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Server FLUP Original'),
                  Text('192.168.15.151'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ManualConnectDialog(controller: LoginController(KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: '192.168.15.151')))));
            },
            child: const Text('Inserir manual'),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ]),
      ),
    );
  }
}
