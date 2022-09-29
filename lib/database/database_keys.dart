import 'package:karaoke_request_client/database/database.dart';

final _database = Database();

enum DatabaseKeys {
  accessToken,
  userId,
  ;

  Future<T?> read<T>({bool persistent = false}) async => await _database.read<T>(name, persistent: persistent);

  Future<void> write<T>(T value, {bool persistent = false}) async => await _database.write(name, value, persistent: persistent);

  Future<T?> readPersistent<T>() async => await _database.readPersistent<T>(name);

  Future<void> writePersistent<T>(T value) async => await _database.writePersistent(name, value);
}
