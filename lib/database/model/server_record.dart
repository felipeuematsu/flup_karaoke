import 'package:json_annotation/json_annotation.dart';

part 'server_record.g.dart';

@JsonSerializable()
class ServerRecord {
  ServerRecord({
    required this.ip,
    required this.name,
    DateTime? lastConnected,
  }) : lastConnected = lastConnected ?? DateTime.now();

  String ip;

  String name;

  DateTime lastConnected;

  Map<String, dynamic> toJson() => _$ServerRecordToJson(this);

  factory ServerRecord.fromJson(Map<String, dynamic> json) => _$ServerRecordFromJson(json);
}
