import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme({Color highlightColor = ColorConstants.peach}) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorConstants.black,
      canvasColor: Colors.white,
      highlightColor: highlightColor,
      scaffoldBackgroundColor: ColorConstants.white,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme({Color highlightColor = ColorConstants.peach}) {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: Colors.white,
      primaryColor: ColorConstants.white,
      highlightColor: highlightColor,
      scaffoldBackgroundColor: ColorConstants.black,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
