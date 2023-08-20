import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FittedBox(
                child: const Text(
                  'FLUP Karaoke',
                  style: TextStyle(fontSize: 128),
                ),
              ),
            ),
            const Spacer(),
            _centerBody(context),
            const Spacer(),
            const Text('Duvidas entre em contato com xX'),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _centerBody(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(32.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Server FLUP Original'),
                      Text('192.168.15.151'),
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 32),
          TextButton(onPressed: () {}, child: const Text('Inserir manual')),
          const SizedBox(height: 64),
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
              SizedBox(width: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  color: Colors.black.withOpacity(0.08),
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2313/2313147.png',
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
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
