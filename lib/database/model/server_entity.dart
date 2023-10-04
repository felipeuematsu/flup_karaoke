import 'package:isar/isar.dart';

part 'server_entity.g.dart';

@Collection()
class ServerRecord {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? ip;

  String? name;

  DateTime lastConnected = DateTime.now();
}
