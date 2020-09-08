import 'dart:async';
import 'package:flutter/material.dart';
import 'package:SalesTrendz/widget/WidgetStandarts.dart';
import 'package:SalesTrendz/screen_sizes/Utilityscreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime(){
    Duration _duration = Duration(seconds: 2);
    return new Timer(_duration, callback);
  }

  void callback(){
    Navigator.pushReplacementNamed(context, 'dahboard');
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    WidgetStandarts.getWidthAndHeight(context);
    UtilityScreen.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
         child: Center(
           child: Image.asset('assets/SalesTrendz-Logo.png'),
         ),
      ),
    );
  }

  
}