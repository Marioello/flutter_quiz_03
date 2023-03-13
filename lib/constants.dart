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

/// Player
const String playerHeaderText = 'Masukan kode kuis untuk bergabung';
const String playerValCodeEmpty = 'Silahkan masukan kode kuis';
const String playerValCodeNotExists = 'Kode tidak dikenali';
const String playerValCodeLength = 'Kode harus 6 angka';
const String playerValNameEmpty = 'Silahkan masukan kode terlebih dahulu';
const String playerValNameExists = 'Nama sudah digunakan';
const String playerValNameLengthLT = 'Nama minimal 3 karakter';
const String playerValNameLengthGT = 'Nama maksimal 10 karakter';
const String playerButtonText = 'Masuk';
