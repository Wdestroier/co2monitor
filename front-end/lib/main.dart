import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'widgets/widgets.dart';

void main() async {
  await dotenv.load(fileName: 'env/dev.env');

  runApp(CO2MonitorApp());
}
