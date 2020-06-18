// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listWeatherForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListWeatherForecast _$ListWeatherForecastFromJson(Map<String, dynamic> json) {
  return ListWeatherForecast()
    ..listWeatherForecast = (json['listWeatherForecast'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherForecast.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListWeatherForecastToJson(
        ListWeatherForecast instance) =>
    <String, dynamic>{'listWeatherForecast': instance.listWeatherForecast};
