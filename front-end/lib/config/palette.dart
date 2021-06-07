import 'package:flutter/material.dart';

class Palette {
  static const int _swatchColorPrimaryValue = 0xFF1F333B;

  static const MaterialColor swatchColor = MaterialColor(
    _swatchColorPrimaryValue,
    <int, Color>{
      50: Color(0xFFE4E7E7),
      100: Color(0xFFBCC2C4),
      200: Color(0xFF8F999D),
      300: Color(0xFF627076),
      400: Color(0xFF415258),
      500: Color(_swatchColorPrimaryValue),
      600: Color(0xFF1B2E35),
      700: Color(0xFF17272D),
      800: Color(0xFF122026),
      900: Color(0xFF0A1419),
    },
  );
}
