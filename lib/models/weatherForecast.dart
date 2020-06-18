import 'package:json_annotation/json_annotation.dart';
import "main.dart";
import "clouds.dart";
import "wind.dart";
import "rain.dart";
import "sys.dart";
part 'weatherForecast.g.dart';

@JsonSerializable()
class WeatherForecast {
    WeatherForecast();

    num dt;
    Main main;
    List weather;
    Clouds clouds;
    Wind wind;
    Rain rain;
    Sys sys;
    String dt_txt;
    
    factory WeatherForecast.fromJson(Map<String,dynamic> json) => _$WeatherForecastFromJson(json);
    Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}
