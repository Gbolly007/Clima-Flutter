import 'package:flutter/material.dart';

class CardStats extends StatelessWidget {
  CardStats({
    this.stats,
  });

  final String stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        stats,
        style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
