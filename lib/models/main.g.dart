// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main()
    ..temp = json['temp'] as num
    ..temp_min = json['temp_min'] as num
    ..temp_max = json['temp_max'] as num
    ..pressure = json['pressure'] as num
    ..sea_level = json['sea_level'] as num
    ..grnd_level = json['grnd_level'] as num
    ..humidity = json['humidity'] as num
    ..temp_kf = json['temp_kf'] as num;
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'sea_level': instance.sea_level,
      'grnd_level': instance.grnd_level,
      'humidity': instance.humidity,
      'temp_kf': instance.temp_kf
    };
