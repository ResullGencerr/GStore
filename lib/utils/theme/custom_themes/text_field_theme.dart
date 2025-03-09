import 'package:flutter/material.dart';

class TTextFieldTheme {
  TTextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
    enabledBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
    focusedBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.black12, width: 1.0)),
    errorBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red, width: 1.0)),
    focusedErrorBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.orange, width: 2.0)),
  );
  static InputDecorationTheme darkTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
    enabledBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
    focusedBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.black12, width: 1.0)),
    errorBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red, width: 1.0)),
    focusedErrorBorder: OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.orange, width: 2.0)),
  );
}
