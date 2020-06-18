import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/listWeatherForecast.dart';
import 'models/weatherForecast.dart';

class Services {
  static const String url =
      "https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&units=metric&appid=b0ed477afabe3883cd633f39b7e03577";

  static Future<ListWeatherForecast> getListWeatherForeCast() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        return parseWeatherForeCast(response.body);
      } else {
        return ListWeatherForecast();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return ListWeatherForecast();
    }
  }

  static ListWeatherForecast parseWeatherForeCast(String responseBody) {
    final parsed = json.decode(responseBody);
    List<WeatherForecast> weatherForecast = parsed['list']
        .map<WeatherForecast>((json) => WeatherForecast.fromJson(json))
        .toList();

    ListWeatherForecast l = ListWeatherForecast();
    l.listWeatherForecast = weatherForecast;
    return l;
  }
}
