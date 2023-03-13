import 'package:flutter/material.dart';

// Local format
const String localFormat = 'id_ID';

// Decoration
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

Widget textHelper(
  String text, {
  double size = 12,
  bool isBold = false,
  Color color = Colors.black,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
      color: color,
    ),
  );
}
