import 'dart:async';
import 'package:clima/models/index.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/threehrforecast.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:clima/models/listWeatherForecast.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'package:nice_button/NiceButton.dart';

import '../Services.dart';

class NewLocationScreen extends StatefulWidget {
  NewLocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _NewLocationScreenState createState() => _NewLocationScreenState();
}

class _NewLocationScreenState extends State<NewLocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  String cityName;
  int temperature;
  String temperatureHigh;
  String temperatureLow;
  String message;
  String imageId;
  String greeting;
  String wind;
  String humidity;
  String sunrise;
  String weatherCondition;
  Timer _timer;
  String search;
  ListWeatherForecast listWeatherForecast;
  int temperatures;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    listWeatherForecast = ListWeatherForecast();
    WeatherModel.getListWeatherForeCast().then((foreCastFromServer) {
      setState(() {
        listWeatherForecast = foreCastFromServer;
      });
    });
  }

  Widget list() {
    return Container(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: listWeatherForecast.listWeatherForecast == null
            ? 0
            : listWeatherForecast.listWeatherForecast.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  Widget row(int index) {
    if (listWeatherForecast.listWeatherForecast[index].main.temp is double) {
      double temp = listWeatherForecast.listWeatherForecast[index].main.temp;
      temperatures = temp.toInt();
    } else {
      temperatures = listWeatherForecast.listWeatherForecast[index].main.temp;
    }

    var newDateTimeObj2 = new DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(listWeatherForecast.listWeatherForecast[index].dt_txt);
    String formattedDate = DateFormat('dd EEEE HH:mm').format(newDateTimeObj2);

    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              'http://openweathermap.org/img/wn/${listWeatherForecast.listWeatherForecast[index].weather[0]['icon']}@2x.png',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$temperatures °C'.toString(),
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    '${listWeatherForecast.listWeatherForecast[index].weather[0]['description']}'
                        .toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      var condition = weatherData['weather'][0]['id'];
      weatherCondition = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
      if (weatherData['main']['temp'] is double) {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
      } else {
        temperature = weatherData['main']['temp'];
      }
      if (weatherData['wind']['speed'] is double) {
        double windy = weatherData['wind']['speed'];
        wind = windy.toString();
      } else {
        int windy = weatherData['wind']['speed'];
        wind = windy.toString();
      }
      if (weatherData['main']['humidity'] is double) {
        double humid = weatherData['main']['humidity'];
        humidity = humid.toString();
      } else {
        int humid = weatherData['main']['humidity'];
        humidity = humid.toString();
      }
      if (weatherData['main']['temp_max'] is double) {
        double tempHigh = weatherData['main']['temp_max'];
        temperatureHigh = tempHigh.toString();
      } else {
        int tempHigh = weatherData['main']['temp_max'];
        temperatureHigh = tempHigh.toString();
      }
      if (weatherData['main']['temp_min'] is double) {
        double tempLow = weatherData['main']['temp_min'];
        temperatureLow = tempLow.toString();
      } else {
        int tempLow = weatherData['main']['temp_min'];
        temperatureLow = tempLow.toString();
      }
      sunrise = DateFormat('kk:mm').format(DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunrise'] * 1000));
      imageId = weatherData['weather'][0]['icon'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temperature);
    });
  }

  _NewLocationScreenState() {
    _timer = new Timer(const Duration(seconds: 300), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoadingScreen();
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE kk:mm').format(now);
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: kGeneralColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: () {
                      EasyDialog(
                          cornerRadius: 15.0,
                          fogOpacity: 0.1,
                          width: 280,
                          height: 180,
                          contentPadding: EdgeInsets.only(
                              top: 12.0), // Needed for the button design
                          contentList: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 30.0)),
                                  Text(
                                    "Enter Location Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textScaleFactor: 1.3,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      search = value;
                                    },
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter City Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                )),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                              child: FlatButton(
                                onPressed: () async {
                                  if (search != null) {
                                    var weatherDataCity = await weatherModel
                                        .getCityWeather(search);
                                    if (weatherDataCity != null) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CityScreen(
                                            locationWeather: weatherDataCity,
                                            cityName: search);
                                      }));
                                    } else {
                                      Navigator.pop(context);
                                      Flushbar(
                                              icon: Icon(
                                                Icons.info_outline,
                                                size: 28.0,
                                                color: Colors.grey,
                                              ),
                                              message:
                                                  "Weather not found for this location, try searching again with another location",
                                              duration: Duration(seconds: 4),
                                              margin: EdgeInsets.all(8),
                                              borderRadius: 8,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING)
                                          .show(context);
                                    }
                                  }
                                },
                                child: Text(
                                  "Search",
                                  textScaleFactor: 1.3,
                                ),
                              ),
                            ),
                          ]).show(context);
                    },
                    child: Icon(
                      Icons.search,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    '$cityName',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '$formattedDate',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Image.network(
                  'http://openweathermap.org/img/wn/$imageId@2x.png',
                  height: 150,
                  width: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.temperatureLow,
                      size: 25.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '$temperature °C',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'HIGH $temperatureHigh °C',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'LOW $temperatureLow °C',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '$weatherCondition'.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20.0,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.sun,
                            size: 30.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'SUNRISE',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$sunrise',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.wind,
                            size: 30.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'WIND',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$wind m/s',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.water,
                            size: 30.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'HUMIDITY',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$humidity%',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55.0,
                ),
                NiceButton(
                  width: 255,
                  elevation: 8.0,
                  radius: 52.0,
                  text: "3 Hour Forecast for the next 5 days",
                  fontSize: 10.0,
                  background: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ThreeHour(cityNames: cityName);
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
