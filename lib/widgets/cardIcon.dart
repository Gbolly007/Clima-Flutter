import 'package:flutter/material.dart';

class CardIcon extends StatelessWidget {
  final IconData icn;
  CardIcon({this.icn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(
        icn,
        size: 30.0,
        color: Colors.black,
      ),
    );
  }
}
