import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: BorderSide(color: Colors.blue),
      textStyle: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
  );

  static OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.blueAccent),
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    ),
  );
}
