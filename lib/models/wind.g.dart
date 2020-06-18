// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind()
    ..speed = json['speed'] as num
    ..deg = json['deg'] as num;
}

Map<String, dynamic> _$WindToJson(Wind instance) =>
    <String, dynamic>{'speed': instance.speed, 'deg': instance.deg};
