import 'package:flup_karaoke/database/database.dart';

final _database = Database();

enum DatabaseKeys {
  accessToken,
  userId,
  host,
  ;

  Future<T?> read<T>({bool persistent = false}) async => _database.read<T>(name, persistent: persistent);

  Future<void> write<T>(T value, {bool persistent = false}) async => _database.write(name, value, persistent: persistent);

  Future<T?> readPersistent<T>() async => _database.readPersistent<T>(name);

  Future<void> writePersistent<T>(T value) async => _database.writePersistent(name, value);
}
