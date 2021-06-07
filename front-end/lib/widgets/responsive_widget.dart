import 'package:flutter/material.dart';

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1200;

bool isTablet(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  return width >= 760 && width < 1200;
}

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 760;
