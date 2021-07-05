import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
              child: AspectRatio(
                aspectRatio: 937 / 227,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
