// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerRecord _$ServerRecordFromJson(Map<String, dynamic> json) => ServerRecord(
      ip: json['ip'] as String,
      name: json['name'] as String,
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
    );

Map<String, dynamic> _$ServerRecordToJson(ServerRecord instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'name': instance.name,
      'lastConnected': instance.lastConnected.toIso8601String(),
    };
