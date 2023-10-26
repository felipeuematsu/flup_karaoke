import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/search/controller/search_view_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt get _ => GetIt.instance;

Function<T extends Object>(T instance, {DisposingFunc? dispose, String? instanceName, bool? signalsReady}) get _rs => _.registerSingleton;

// ignore: unused_element
void Function<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}) get _rf => _.registerFactory;

Future<void> setupDependencies() async {
  final db = AppDB(await SharedPreferences.getInstance());
  await db.openDatabase();
  _rs(db);
  _rf(() => SearchViewController());
}
