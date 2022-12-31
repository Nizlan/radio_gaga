import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Style {
  static final Gradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [HexColor('#0f0c29'), HexColor('#302b63'), HexColor('#24243e')],
  );

  static const double playerHeight = 160;
  static const transitionDuration = Duration(milliseconds: 400);
}
