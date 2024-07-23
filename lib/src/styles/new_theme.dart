import 'package:flutter/material.dart';

const Color myColor =
    Color(0xFF123456); // Substitua 0xFF123456 pela sua cor HEX

final ThemeData newTheme = ThemeData(
  primaryColor: myColor,
  hintColor: myColor,
  colorSchemeSeed: const Color.fromARGB(255, 0, 91, 226),
  fontFamily: 'Rubik',
);
