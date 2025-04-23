import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: false, // disable Material 3 (this causes the purple/pink)
  brightness: Brightness.light,
  scaffoldBackgroundColor: white,
  primaryColor: lightGrey,
  cardColor: whiteGrey,
  iconTheme: const IconThemeData(color: black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: black),
    bodyMedium: TextStyle(color: black),
    titleLarge: TextStyle(color: black),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: lightGrey,
    elevation: 0,
    iconTheme: IconThemeData(color: black),
    titleTextStyle: TextStyle(color: black, fontSize: 20),
  ),
  colorScheme: const ColorScheme.light(
    surface: white,
    primary: lightGrey,
    onPrimary: black,
    onSurface: black,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: black,
  primaryColor: blackGrey,
  cardColor: blackGrey,
  iconTheme: const IconThemeData(color: white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: white),
    bodyMedium: TextStyle(color: white),
    titleLarge: TextStyle(color: white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: blackGrey,
    elevation: 0,
    iconTheme: IconThemeData(color: white),
    titleTextStyle: TextStyle(color: white, fontSize: 20),
  ),
  colorScheme: const ColorScheme.dark(
    surface: black,
    primary: blackGrey,
    onPrimary: white,
    onSurface: white,
  ),
);
