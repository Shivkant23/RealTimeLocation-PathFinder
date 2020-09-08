
import 'package:flutter/material.dart';

class UtilityScreen{
  static UtilityScreen _instance;
  static const int defaultWidth = 1080;
  static const int defaultHeight = 1920;
  
  num uiWidthPixel;
  num uiHeightPixel;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;

  UtilityScreen._();


  factory UtilityScreen(){
    return _instance;
  }

  static void init(BuildContext context,
    {num width = defaultWidth,
    num height = defaultHeight,
    bool allowFontScaling = false}
  ){
      if(_instance == null){
        _instance = UtilityScreen._();
      }
      _instance.uiWidthPixel = width;
    _instance.uiHeightPixel = height;
    _instance.allowFontScaling = allowFontScaling;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;
  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => _textScaleFactor;
  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _pixelRatio;
  /// The horizontal extent of this size.
  static double get screenWidthDp => _screenWidth;
  ///The vertical extent of this size. dp
  static double get screenHeightDp => _screenHeight;
  /// The vertical extent of this size. px
  static double get screenWidth => _screenWidth * _pixelRatio;
  /// The vertical extent of this size. px
  static double get screenHeight => _screenHeight * _pixelRatio;
  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight;
  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;
  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiWidthPixel;
  double get scaleHeight => _screenHeight / uiHeightPixel;
  double get scaleText => scaleWidth;
  num setWidth(num width) => width * scaleWidth;
  num setHeight(num height) => height * scaleHeight;

  num setSp(num fontSize, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));
}