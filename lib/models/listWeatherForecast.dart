import 'package:json_annotation/json_annotation.dart';
import "weatherForecast.dart";
part 'listWeatherForecast.g.dart';

@JsonSerializable()
class ListWeatherForecast {
    ListWeatherForecast();

    List<WeatherForecast> listWeatherForecast;
    
    factory ListWeatherForecast.fromJson(Map<String,dynamic> json) => _$ListWeatherForecastFromJson(json);
    Map<String, dynamic> toJson() => _$ListWeatherForecastToJson(this);
}
