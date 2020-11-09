import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String cardText;
  CardTitle({this.cardText});

  @override
  Widget build(BuildContext context) {
    return Text(
      cardText,
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 10.0,
        color: Colors.black,
      ),
    );
  }
}
