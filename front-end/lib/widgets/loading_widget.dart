import 'package:co2monitor/config/palette.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.swatchColor[50],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
