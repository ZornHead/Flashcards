import 'package:flutter/material.dart';
import 'dart:math';

class ScalerConfig {
  MediaQueryData _mediaQueryData;
  double _designWidth = 375;
  double _designHeight = 812;
  double screenWidth;
  double screenHeight;

  ScalerConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  double _ratioH() {
    return screenWidth / _designWidth;
  }

  double scalerH(double size) {
    return _ratioH() * size;
  }

  double _ratioV() {
    return screenHeight / _designHeight;
  }

  double scalerV(double size) {
    return _ratioV() * size;
  }

  double scalerT(double size) {
    return sqrt((pow(scalerV(size), 2) + pow(scalerH(size), 2)) / 2);
  }
}
