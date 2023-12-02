import 'dart:convert';

import 'package:flup_karaoke/database/model/server_record.dart';
import 'package:flup_karaoke/extensions/locale.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'keys.dart';

class AppDB {
  final SharedPreferences prefs;

  AppDB(this.prefs);

  factory AppDB.get() => GetIt.I<AppDB>();

  Future<bool> toggleDarkMode(BuildContext context) async {
    final darkMode = prefs.getBool(_darkModeKey) ?? false;
    await prefs.setBool(_darkModeKey, !darkMode);
    return FlupKApp.of(context).darkMode.value = !darkMode;
  }

  bool get darkMode => prefs.getBool(_darkModeKey) ?? false;

  Future<void> setCurrentServer(ServerRecord? server) async {
    if (server == null || server.ip.isEmpty || server.name.isEmpty) {
      await prefs.remove(_serverKey);
    } else {
      final servers = this.servers.toList()
        ..removeWhere((element) => element.ip == server.ip)
        ..insert(0, server);
      this.servers = servers;
      await prefs.setString(_serverKey, jsonEncode(server.toJson()));
    }
  }

  ServerRecord? get currentServer {
    final server = prefs.getString(_serverKey);
    if (server == null) return null;
    final jsonDecoded = jsonDecode(server);
    if (jsonDecoded is! Map<String, dynamic>) return null;

    return ServerRecord.fromJson(jsonDecoded);
  }

  Locale? get locale {
    final locale = prefs.getString(_localeKey);
    if (locale == null) return null;
    final jsonDecoded = jsonDecode(locale);
    if (jsonDecoded is! Map<String, dynamic>) return null;

    return localeFromJson(jsonDecoded);
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, jsonEncode(locale.toJson()));
    }
  }

  SingerModel? get currentSinger {
    final singer = prefs.getString(_singerKey);
    if (singer == null) return null;
    final jsonDecoded = jsonDecode(singer);
    if (jsonDecoded is! Map<String, dynamic>) return null;

    return SingerModel.fromJson(jsonDecoded);
  }

  Future<void> setCurrentSinger(SingerModel? singer) async {
    if (singer == null) {
      await prefs.remove(_singerKey);
    } else {
      await prefs.setString(_singerKey, jsonEncode(singer.toJson()));
    }
  }

  List<ServerRecord> get servers => prefs.getStringList(_serverListKey)?.map((e) => ServerRecord.fromJson(jsonDecode(e) as Map<String, dynamic>)).toList() ?? [];

  set servers(List<ServerRecord> value) {
    prefs.setStringList(_serverListKey, value.map((e) => jsonEncode(e.toJson())).toList());
  }
}
