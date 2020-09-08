import 'package:flutter/material.dart';

class UIColors{
  static Color blackColor = Colors.black;
  static Color black12Color = Colors.black12;
  static Color black26Color = Colors.black26;
  static Color black45Color = Colors.black45;
  static Color black54Color = Colors.black54;
  static Color whiteColor = Colors.white;
  static Color white70Color = Colors.white70;
  static Color deepPurpleColor = Colors.deepPurple;
  static Color blueColor = Colors.blue;
  static Color blueAccentColor = Colors.blueAccent;
  static Color redColor = Colors.red;
  static Color orangeColor = Colors.orange;
  static Color themeColor1 = Color(0xFFFF9844);
  static Color themeColor2 = Color(0xFFFE8853);
  static Color themeColor3 = Color(0xFFFD25567);
  static Color buttonColorOrange = Colors.orange;

  static List<Color> orangeGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD25567),
  ];

  static List<Color> aquaGradients = [
    Color(0xFF5AEAF1),
    Color(0xFF8EF7DA),
  ];

  // static List<Color> signInGradients = [
  //   Color(0xFFFF9844),
  //   Color(0xFFFE8853),
  //   Color(0xFFFD25567),
  // ];

  static List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];

  static Map<int, Color> colorCodes = {
  50: Color.fromRGBO(51, 51, 255, .1),
  100: Color.fromRGBO(51, 51, 255, .2),
  200: Color.fromRGBO(51, 51, 255, .3),
  300: Color.fromRGBO(51, 51, 255, .4),
  400: Color.fromRGBO(51, 51, 255, .5),
  500: Color.fromRGBO(51, 51, 255, .6),
  600: Color.fromRGBO(51, 51, 255, .7),
  700: Color.fromRGBO(51, 51, 255, .8),
  800: Color.fromRGBO(51, 51, 255, .9),
  900: Color.fromRGBO(51, 51, 255, 1),
};
// Green color code: FF93cd48
static MaterialColor customColor = MaterialColor(0xFF448AFF, colorCodes);

}