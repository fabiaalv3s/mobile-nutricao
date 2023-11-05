import 'package:flutter/material.dart';

ThemeData colorsOne = ThemeData(
    primaryColor: const Color.fromRGBO(13, 25, 43, 1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(13, 25, 43, 1),
        secondary: const Color.fromRGBO(223, 166, 42, 1)));

ThemeData colorsTwo = ThemeData(
    primaryColor: const Color.fromRGBO(232, 204, 143, 1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(232, 204, 143, 1),
        secondary: Color.fromARGB(255, 64, 156, 231)));
ThemeData colorsThree = ThemeData(
    primaryColor: const Color.fromRGBO(217, 217, 217, 1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(217, 217, 217, 1),
        secondary: const Color.fromRGBO(0, 0, 0, 1)));

ThemeData myTextThemes = ThemeData(
    textTheme: TextTheme(
        displayLarge: const TextStyle(
            fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 40,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: colorsTwo.colorScheme.primary),
        displaySmall: TextStyle(
            fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.bold,
            color: colorsTwo.colorScheme.secondary
            ),
        headlineLarge: const TextStyle(
            fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        headlineMedium: const TextStyle(
            fontSize: 16, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        headlineSmall: const TextStyle(
            fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(
            fontSize: 40, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        titleMedium: const TextStyle(
            fontSize: 16, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        titleSmall: const TextStyle(
            fontSize: 14, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        labelLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.normal),
        labelMedium: const TextStyle(
            fontSize: 16,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.normal),
        labelSmall: const TextStyle(
            fontSize: 12,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.normal)));

ThemeData buttonsTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(colorsOne.colorScheme.primary))
              ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(colorsTwo.colorScheme.secondary),
          textStyle: MaterialStateProperty.all(const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold))
              )),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(myTextThemes.textTheme.titleLarge),
          backgroundColor:
              MaterialStateProperty.all(colorsTwo.colorScheme.primary))),
);

ThemeData myAppBarTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: colorsOne.colorScheme.primary));
