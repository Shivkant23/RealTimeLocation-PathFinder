import 'package:SalesTrendz/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:SalesTrendz/screen_sizes/size_config.dart';
import 'package:SalesTrendz/screens/SplashScreen.dart';
import 'package:SalesTrendz/widget/Colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'SalesTrendz',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: UIColors.customColor,
              ),
              home: SplashScreen(),
              routes: {
                'dahboard' : (context) => Dashboard(),
                // 'login' : (context) => LoginScreen()
              },
            );
          },
        );
      },
    );
  }
}


