import 'package:co2monitor/config/palette.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String imageName, textMessage;

  const NotFound({
    Key? key,
    required this.imageName,
    required this.textMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Palette.swatchColor[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imageName),
              const SizedBox(height: 20.0),
              Text(
                textMessage,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
