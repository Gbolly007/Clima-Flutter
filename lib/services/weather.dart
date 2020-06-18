import 'package:clima/models/listWeatherForecast.dart';
import 'package:clima/models/weatherForecast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const apiKey = 'b0ed477afabe3883cd633f39b7e03577';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapURLForecastURL =
    'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    print(weatherData);
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
