import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

enum _ServerTestStatus { idle, testing, success, error }

class ManualConnectDialog extends StatefulWidget {
  const ManualConnectDialog({super.key, required this.controller});

  final LoginController controller;

  @override
  State<ManualConnectDialog> createState() => _ManualConnectDialogState();
}

class _ManualConnectDialogState extends State<ManualConnectDialog> {
  final _serverTestStatus = ValueNotifier(_ServerTestStatus.idle);

  final db = AppDB.get();

  Timer? _timer;

  late final _ipController = TextEditingController();
  late final _nameController = TextEditingController();

  void onAddressChanged(String value) {
    _timer?.cancel();
    _serverTestStatus.value = _ServerTestStatus.idle;
    if (value.isEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 500), () async {
      _serverTestStatus.value = _ServerTestStatus.testing;
      final result = await widget.controller.testHost(value);
      _serverTestStatus.value = result ? _ServerTestStatus.success : _ServerTestStatus.error;
    });
  }

  void clearAddress() {
    _timer?.cancel();
    _serverTestStatus.value = _ServerTestStatus.idle;
    _ipController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(contentPadding: const EdgeInsets.all(32.0), children: [
      SizedBox(
        width: 300,
        child: Column(children: [
          Text(
            FlupS.of(context).manualConnection,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              constraints: const BoxConstraints(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelText: FlupS.of(context).name,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              suffixIcon: IconButton(onPressed: clearAddress, icon: const Icon(Icons.close)),
            ),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: TextField(
                controller: _ipController,
                onChanged: onAddressChanged,
                decoration: InputDecoration(
                  constraints: const BoxConstraints(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelText: FlupS.of(context).manualConnectionPlaceholder,
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  suffixIcon: IconButton(onPressed: clearAddress, icon: const Icon(Icons.close)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox.square(
              dimension: 24,
              child: ValueListenableBuilder(
                valueListenable: _serverTestStatus,
                builder: (context, value, child) {
                  switch (value) {
                    case _ServerTestStatus.idle:
                      return const SizedBox();
                    case _ServerTestStatus.testing:
                      return const CircularProgressIndicator();
                    case _ServerTestStatus.success:
                      return Icon(Icons.check, color: Theme.of(context).colorScheme.primary);
                    case _ServerTestStatus.error:
                      return Icon(Icons.close, color: Theme.of(context).colorScheme.error);
                  }
                },
              ),
            ),
          ]),
          const SizedBox(height: 32),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(FlupS.of(context).cancel),
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _serverTestStatus,
                child: Text(FlupS.of(context).manualConnectionButton),
                builder: (context, value, child) => FilledButton(
                  onPressed: value == _ServerTestStatus.success ? () => _goToHome(ServerRecord(name: _nameController.text, ip: _ipController.text)) : null,
                  child: child,
                ),
              ),
            ),
          ]),
        ]),
      ),
    ]);
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
