import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_entity.g.dart';

@Collection()
@JsonSerializable()
class ServerRecord {
  ServerRecord({
    this.ip,
    this.name,
  });

  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? ip;

  String? name;

  DateTime lastConnected = DateTime.now();

  Map<String, dynamic> toJson() => _$ServerRecordToJson(this);

  factory ServerRecord.fromJson(Map<String, dynamic> json) => _$ServerRecordFromJson(json);
}
