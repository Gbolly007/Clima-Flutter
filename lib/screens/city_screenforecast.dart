import 'dart:async';
import 'package:clima/models/listWeatherForecast.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nice_button/NiceButton.dart';

class ThreeHourCity extends StatefulWidget {
  ThreeHourCity({this.cityName});
  final String cityName;
  @override
  _ThreeHourCityState createState() => _ThreeHourCityState();
}

class _ThreeHourCityState extends State<ThreeHourCity> {
  int temperatures;
  String city;
  ListWeatherForecast listWeatherForecast;

  @override
  void initState() {
    super.initState();
    listWeatherForecast = ListWeatherForecast();
    city = widget.cityName;
    WeatherModel.getListWeatherForeCastByCity(widget.cityName)
        .then((foreCastFromServer) {
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
                  SizedBox(
                    height: 10.0,
                  ),
                  NiceButton(
                    width: 255,
                    elevation: 8.0,
                    radius: 52.0,
                    text: "3 Hour Forecast for $city".toUpperCase(),
                    fontSize: 10.0,
                    background: Colors.black,
                    onPressed: () {},
                  ),
                  list(),
                ]),
          ),
        ),
      ),
    );
  }
}
