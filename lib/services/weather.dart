import 'package:clima/models/listWeatherForecast.dart';
import 'package:clima/models/weatherForecast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/location.dart';
import 'package:clima/services/networking.dart';


const apiKey = 'b0ed477afabe3883cd633f39b7e03577';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapURLForecastURL =
    'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  static Future<ListWeatherForecast> getListWeatherForeCast() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      final response = await http.get(
          '$openWeatherMapURLForecastURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');

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

  static Future<ListWeatherForecast> getListWeatherForeCastByCity(
      String cityName) async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      final response = await http.get(
          '$openWeatherMapURLForecastURL?q=$cityName&units=metric&appid=$apiKey');
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

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int weatherId) {
    String iconType = "";
    if (weatherId >= 200 && weatherId <= 232) {
      iconType = "wi-thunderstorm";
    } else if (weatherId >= 300 && weatherId <= 321) {
      iconType = "wi-showers";
    } else if (weatherId >= 500 && weatherId <= 531) {
      iconType = "wi-rain";
    } else if (weatherId >= 600 && weatherId <= 622) {
      iconType = "wi-snow";
    } else if (weatherId == 701 || weatherId == 741) {
      iconType = "wi-fog";
    } else if (weatherId == 711) {
      iconType = "wi-smoke";
    } else if (weatherId == 721) {
      iconType = "wi-day-haze";
    } else if (weatherId == 731 || weatherId == 761) {
      iconType = "wi-dust";
    } else if (weatherId == 751) {
      iconType = "wi-sandstorm";
    } else if (weatherId == 762) {
      iconType = "wi-volcano";
    } else if (weatherId == 771) {
      iconType = "wi-cloudy-gusts";
    } else if (weatherId == 781) {
      iconType = "wi-tornado";
    } else if (weatherId == 800) {
      iconType = "wi-day-sunny";
    } else if (weatherId > 801 && weatherId <= 804) {
      iconType = "wi-day-cloudy";
    }

    return iconType;
  }
}
