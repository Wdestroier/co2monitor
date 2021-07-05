import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/pages/pages.dart';
import 'package:co2monitor/config/palette.dart';
import 'package:flutter/material.dart';

class CO2MonitorApp extends StatelessWidget {
  final HttpClient httpClient = new HttpClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.swatchColor,
      ),
      home: HomePage(
        httpClient: httpClient,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
