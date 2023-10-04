import 'package:flup_karaoke/database/model/server_entity.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Isar> openDatabase() async {
  return Isar.open(_schemas, directory: (await getApplicationDocumentsDirectory()).path);
}

Isar get database => Isar.getInstance()!;

final _schemas = <CollectionSchema>[
  ServerRecordSchema,
];

Future<bool> toggleDarkMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final darkMode = prefs.getBool('darkMode') ?? false;
  await prefs.setBool('darkMode', !darkMode);
  FlupKApp.of(context).isDarkMode.value = !darkMode;
  return !darkMode;
}

Future<bool> isDarkMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('darkMode') ?? false;
}
