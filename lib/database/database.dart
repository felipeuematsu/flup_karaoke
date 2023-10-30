import 'dart:convert';

import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/extensions/locale.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'keys.dart';

const _schemas = <CollectionSchema>[
  ServerRecordSchema,
];

class AppDB {
  final SharedPreferences prefs;

  static const String localeKey = 'localeKey';

  AppDB(this.prefs);

  factory AppDB.get() => GetIt.I<AppDB>();

  Isar? _isar;

  Isar get isar {
    assert(_isar != null, 'Database is not initialized. Run `await AppDB.get().openDatabase()` first.');
    return _isar!;
  }

  Future<Isar> openDatabase() async {
    return _isar = await Isar.open(_schemas, directory: (await getApplicationDocumentsDirectory()).path);
  }

  Future<bool> toggleDarkMode(BuildContext context) async {
    final darkMode = prefs.getBool(darkModeKey) ?? false;
    await prefs.setBool(darkModeKey, !darkMode);
    return FlupKApp.of(context).darkMode.value = !darkMode;
  }

  bool get darkMode => prefs.getBool(darkModeKey) ?? false;

  Future<void> setCurrentServer(ServerRecord? server) async {
    if (server == null || server.ip == null || server.ip!.isEmpty || server.name == null || server.name!.isEmpty) {
      await prefs.remove(serverKey);
    } else {
      await prefs.setString(serverKey, jsonEncode(server.toJson()));
    }
  }

  ServerRecord? get currentServer {
    final server = prefs.getString(serverKey);
    if (server == null) return null;
    final jsonDecoded = jsonDecode(server);
    if (jsonDecoded is! Map<String, dynamic>) return null;

    return ServerRecord.fromJson(jsonDecoded);
  }

  Locale? get locale {
    final locale = prefs.getString(localeKey);
    if (locale == null) return null;
    final jsonDecoded = jsonDecode(locale);
    if (jsonDecoded is! Map<String, dynamic>) return null;

    return localeFromJson(jsonDecoded);
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await prefs.remove(localeKey);
    } else {
      await prefs.setString(localeKey, jsonEncode(locale.toJson()));
    }
  }
}
