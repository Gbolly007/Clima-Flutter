// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) {
  return WeatherForecast()
    ..dt = json['dt'] as num
    ..main = json['main'] == null
        ? null
        : Main.fromJson(json['main'] as Map<String, dynamic>)
    ..weather = json['weather'] as List
    ..clouds = json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
    ..wind = json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>)
    ..rain = json['rain'] == null
        ? null
        : Rain.fromJson(json['rain'] as Map<String, dynamic>)
    ..sys = json['sys'] == null
        ? null
        : Sys.fromJson(json['sys'] as Map<String, dynamic>)
    ..dt_txt = json['dt_txt'] as String;
}

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'rain': instance.rain,
      'sys': instance.sys,
      'dt_txt': instance.dt_txt
    };
