import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,

  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
);
