import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme(Color _highlightColor) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorConstants.black,
      highlightColor: _highlightColor,
      scaffoldBackgroundColor: ColorConstants.white,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme(Color _highlightColor) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorConstants.white,
      highlightColor: _highlightColor,
      scaffoldBackgroundColor: ColorConstants.black,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}