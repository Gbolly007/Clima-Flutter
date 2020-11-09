import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    this.txt,
  });

  final TextEditingController txt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
            hintText: "Enter City Name",
            hintStyle: TextStyle(color: Colors.black38),
            border: InputBorder.none),
        controller: txt,
      ),
    );
  }
}
