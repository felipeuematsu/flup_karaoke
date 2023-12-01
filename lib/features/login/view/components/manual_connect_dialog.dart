import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/configuration/constants.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/ip_helper.dart';
import 'package:flup_karaoke/mock/karaoke_api_service_mock.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

enum _ServerTestStatus { idle, testing, success, error }

class ManualConnectDialog extends StatefulWidget {
  const ManualConnectDialog({super.key});

  @override
  State<ManualConnectDialog> createState() => _ManualConnectDialogState();
}

class _ManualConnectDialogState extends State<ManualConnectDialog> {
  final controller = GetIt.I<LoginController>();

  final _serverTestStatus = ValueNotifier(_ServerTestStatus.idle);

  final db = AppDB.get();

  Timer? _timer;

  final _ipController = TextEditingController();
  final _nameController = TextEditingController();

  final manualIpFocusNode = FocusNode();
  final manualNameFocusNode = FocusNode();

  void onAddressChanged(String value) {
    _timer?.cancel();
    _serverTestStatus.value = _ServerTestStatus.idle;
    if (value.isEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 500), () async {
      _serverTestStatus.value = _ServerTestStatus.testing;
      final result = await controller.testHost(value);
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
    return SimpleDialog(elevation: 10, contentPadding: const EdgeInsets.all(32.0), children: [
      SizedBox(
        width: 300,
        child: Column(children: [
          Text(
            FlupS.of(context).manualConnection,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const Gap(32),
          TextField(
            focusNode: manualNameFocusNode,
            onTapOutside: (_) => manualNameFocusNode.unfocus(),
            onSubmitted: (_) => manualIpFocusNode.requestFocus(),
            textInputAction: TextInputAction.next,
            controller: _nameController,
            decoration: InputDecoration(
              constraints: const BoxConstraints(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelText: FlupS.of(context).name,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              suffixIcon: IconButton(onPressed: _nameController.clear, icon: const Icon(Icons.close)),
            ),
          ),
          const Gap(16),
          Row(children: [
            Expanded(
              child: TextField(
                focusNode: manualIpFocusNode,
                onTapOutside: (_) => manualIpFocusNode.unfocus(),
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
            const Gap(16),
            SizedBox.square(
              dimension: 24,
              child: ValueListenableBuilder(
                valueListenable: _serverTestStatus,
                builder: (context, value, child) => switch (value) {
                  _ServerTestStatus.idle => const SizedBox(),
                  _ServerTestStatus.testing => const CircularProgressIndicator(),
                  _ServerTestStatus.success => Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                  _ServerTestStatus.error => Icon(Icons.close, color: Theme.of(context).colorScheme.error)
                },
              ),
            ),
          ]),
          const Gap(32),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(FlupS.of(context).cancel),
              ),
            ),
            const Gap(32),
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
    db.isar.writeTxn(() => db.isar.serverRecords.put(server));

    db.setCurrentServer(server);
    final ip = server.ip;
    if (ip != null) {
      final service = isMockOn ? KaraokeApiServiceMock() : KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: formatHost(ip)?.toString() ?? ip));
      GetIt.I.registerSingleton<KaraokeApiService>(service);

      AutoRouter.of(context).replaceAll([const HomeRoute()]);
    }
  }
}
