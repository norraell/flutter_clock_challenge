import 'package:flutter/material.dart';

class ClockColors {
  ClockColors._();

  /// same structure as material color schemes
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFEDF5FF),
      100: Color(0xFFD0E2FF),
      200: Color(0xFFa6c8ff),
      300: Color(0xFF78a9ff),
      400: Color(0xFF4589ff),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF0043ce),
      700: Color(0xFF002d9c),
      800: Color(0xFF001d6c),
      900: Color(0xFF001141),
    },
  );
  static const int _bluePrimaryValue = 0xFF2196F3;

  static const MaterialColor coolGrey = MaterialColor(
    _coolGreyPrimaryValue,
    <int, Color>{
      50: Color(0xFFf2f4f8),
      100: Color(0xFFdde1e6),
      200: Color(0xFFc1c7cd),
      300: Color(0xFFa2a9b0),
      400: Color(0xFF878d96),
      500: Color(_coolGreyPrimaryValue),
      600: Color(0xFF4d5358),
      700: Color(0xFF343a3f),
      800: Color(0xFF21272a),
      900: Color(0xFF121619),
    },
  );
  static const int _coolGreyPrimaryValue = 0xFF697077;
}
