import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  /// Customizable  Light Theme Elevated Button Style

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );

  /// Customizable  Dark Theme Elevated Button Style

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );
}
