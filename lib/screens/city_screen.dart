import 'package:clima/darkThemeProv.dart';
import 'package:clima/models/index.dart';
import 'package:clima/widgets/cardIcon.dart';
import 'package:clima/widgets/cardStats.dart';
import 'package:clima/widgets/cardTitle.dart';
import 'package:clima/widgets/highLow.dart';
import 'package:clima/widgets/searchField.dart';
import 'package:clima/models/listWeatherForecast.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class CityScreen extends StatefulWidget {
  CityScreen({this.locationWeather, this.cityName});
  final locationWeather;
  final String cityName;
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
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

  String search;
  ListWeatherForecast listWeatherForecast;
  int temperatures;
  final TextEditingController txt = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    listWeatherForecast = ListWeatherForecast();
    WeatherModel.getListWeatherForeCastByCity(cityName)
        .then((foreCastFromServer) {
      setState(() {
        listWeatherForecast = foreCastFromServer;
      });
    });
  }

  Widget list(bool darkTheme) {
    return Container(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listWeatherForecast.listWeatherForecast == null
            ? 0
            : listWeatherForecast.listWeatherForecast.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index, darkTheme);
        },
      ),
    );
  }

  Widget row(int index, bool darkTheme) {
    if (listWeatherForecast.listWeatherForecast[index].main.temp is double) {
      double temp = listWeatherForecast.listWeatherForecast[index].main.temp;
      temperatures = temp.toInt();
    } else {
      temperatures = listWeatherForecast.listWeatherForecast[index].main.temp;
    }

    var newDateTimeObj2 = new DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(listWeatherForecast.listWeatherForecast[index].dt_txt);
    String formattedDate = DateFormat('EE HH:mm').format(newDateTimeObj2);
    String iconType = weatherModel.getMessage(
        listWeatherForecast.listWeatherForecast[index].weather[0]['id']);
    String main =
        listWeatherForecast.listWeatherForecast[index].weather[0]['main'];

    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            formattedDate,
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                WeatherIcons.fromString(
                  iconType,
                  fallback: WeatherIcons.na,
                ),
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '$temperatures °C'.toString(),
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: darkTheme ? Colors.white : Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '$main',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: darkTheme ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
    );
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        wind = "N/A";
        cityName = 'N/A';
        humidity = "N/A";
        temperatureHigh = "N/A";
        temperatureLow = "N/A";
        weatherCondition = "N/A";
        weatherIcon = "N/A";
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

      message = weatherModel.getMessage(temperature);
      weatherIcon = weatherModel.getMessage(condition);
    });
  }

  @override
  void dispose() {
    super.dispose();
    txt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.lightbulb_outline,
          color: Colors.white,
        ),
        onPressed: () {
          bool theme = themeChange.darkTheme;
          themeChange.darkTheme = !theme;
        },
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: themeChange.darkTheme ? Colors.black87 : kGeneralColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                          shape: CircleBorder(side: BorderSide.none),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff5f8fd),
                              borderRadius: BorderRadius.circular(30)),
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: <Widget>[
                              SearchField(txt: txt),
                              InkWell(
                                onTap: () async {
                                  if (txt.text != null) {
                                    var weatherDataCity = await weatherModel
                                        .getCityWeather(txt.text.trim());
                                    if (weatherDataCity != null) {
                                      updateUI(weatherDataCity);
                                    } else {
                                      return _scaffoldKey.currentState
                                          .showSnackBar(
                                        new SnackBar(
                                          content: new Text(
                                              "Location does not exist, please check and try again"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    '$cityName',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20.0,
                        color: themeChange.darkTheme
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                weatherIcon == null
                    ? Text("N/A")
                    : IconButton(
                        icon: Icon(
                          WeatherIcons.fromString(
                            weatherIcon,
                            fallback: WeatherIcons.na,
                          ),
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.temperatureLow,
                      size: 25.0,
                      color:
                          themeChange.darkTheme ? Colors.white : Colors.black,
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
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children: <Widget>[
                        HighLowWidget(
                            hilo: "HIGH",
                            temp: temperatureHigh,
                            darkTheme: themeChange.darkTheme),
                        HighLowWidget(
                            hilo: "LOW",
                            temp: temperatureLow,
                            darkTheme: themeChange.darkTheme),
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
                      color:
                          themeChange.darkTheme ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                  child: Divider(
                    color: themeChange.darkTheme ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 120,
                        decoration: cardDec,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CardTitle(
                                    cardText: "SUNSHINE",
                                  ),
                                  CardIcon(
                                    icn: FontAwesomeIcons.sun,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CardStats(stats: "$sunrise"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 90,
                        width: 120,
                        decoration: cardDec,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CardTitle(
                                    cardText: "WIND",
                                  ),
                                  CardIcon(
                                    icn: FontAwesomeIcons.wind,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CardStats(stats: "$wind m/s"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 90,
                        width: 120,
                        decoration: cardDec,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CardTitle(
                                    cardText: "HUMIDITY",
                                  ),
                                  CardIcon(
                                    icn: FontAwesomeIcons.tint,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            CardStats(stats: "$humidity%"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '5 days WeatherForecast',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(),
                      SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                listWeatherForecast == null
                    ? Text("N/A")
                    : list(themeChange.darkTheme)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
