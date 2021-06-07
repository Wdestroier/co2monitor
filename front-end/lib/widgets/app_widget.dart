import 'package:co2monitor/pages/pages.dart';
import 'package:co2monitor/config/palette.dart';
import 'package:flutter/material.dart';

class CO2MonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.swatchColor,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
