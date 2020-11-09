import 'package:flutter/material.dart';

class HighLowWidget extends StatelessWidget {
  final String hilo;
  final String temp;
  final bool darkTheme;
  HighLowWidget({this.hilo, this.temp, this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$hilo $temp °C',
      style: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: darkTheme ? Colors.white : Colors.black),
    );
  }
}
