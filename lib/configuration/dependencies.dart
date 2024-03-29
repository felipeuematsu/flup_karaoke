import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/commons/controller/current_singer_controller.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/features/now_playing/controller/mini_player_controller.dart';
import 'package:flup_karaoke/features/search/controller/search_view_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt get _ => GetIt.instance;

Function<T extends Object>(T instance, {DisposingFunc? dispose, String? instanceName, bool? signalsReady}) get _rs => _.registerSingleton;

void Function<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}) get _rf => _.registerFactory;

Future<void> setupDependencies() async {
  final db = AppDB(await SharedPreferences.getInstance());
  _rs(db);
  _rf(() => SearchViewController());
  _rf(() => LoginController());
  _rs(NowPlayingController());
  _rf(() => CurrentSingerController());
}
