import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Styling {
  static final dateFormat = new DateFormat('dd-MMM-yyyy');
  static final Color splashTextColor = HexColor("#165591");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.tryParse(hexColor, radix: 16) ?? 0;
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}