import 'package:flutter/material.dart';
import 'package:SalesTrendz/widget/Colors.dart';

enum MyThemeKeys { BLUE, ORANGE }

class MyThemes {
  static ThemeData blueTheme(){
    
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: Colors.blueAccent,
      iconTheme: IconThemeData(color: Colors.blueAccent),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.black.withOpacity(0.5)
      ),
      navigationRailTheme: NavigationRailThemeData(
        unselectedLabelTextStyle: TextStyle(color: Colors.black54),
        selectedIconTheme: IconThemeData(color: Colors.blueAccent),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blueAccent),
      indicatorColor: Colors.blueAccent,
      primaryIconTheme: IconThemeData(color: Colors.blueAccent),
      inputDecorationTheme: InputDecorationTheme(),
    );
  }

  static ThemeData orangeTheme(){
    
    final ThemeData base = ThemeData.light();
    // TextTheme textThemeOrange = TextTheme(
    //   bodyText2: TextStyle(fontSize: 14.0),
    // );
    return base.copyWith(
      // textTheme: TextTheme(
      //   // subtitle1: ,
      //   subtitle1: TextStyle(fontSize: 14.0, color: UIColors.buttonColorOrange),
      // ),
      primaryColor: UIColors.buttonColorOrange,
      navigationRailTheme: NavigationRailThemeData(
        unselectedLabelTextStyle: TextStyle(color: Colors.black54),
        selectedIconTheme: IconThemeData(color: UIColors.buttonColorOrange),
      ),
      iconTheme: IconThemeData(color: UIColors.buttonColorOrange),
      tabBarTheme: TabBarTheme(
        labelColor: UIColors.buttonColorOrange,
        unselectedLabelColor: Colors.black.withOpacity(0.5),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: UIColors.buttonColorOrange),
      indicatorColor: Colors.redAccent,
      primaryIconTheme: IconThemeData(color: UIColors.buttonColorOrange),
      inputDecorationTheme: InputDecorationTheme(),
    );
  }

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.BLUE:
        return blueTheme();
      case MyThemeKeys.ORANGE:
        return orangeTheme();
      default:
        return blueTheme();
    }
  }
}