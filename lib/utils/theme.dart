import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme(
      {Color highlightColor = ColorConstants.green,
      ThemeColor themeColor = ThemeColor.Light}) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorConstants.black,
      primaryColorDark: getPrimaryColorDark(highlightColor, themeColor),
      backgroundColor: getBackgroundColor(highlightColor, themeColor),
      canvasColor: Colors.white,
      highlightColor: highlightColor,
      scaffoldBackgroundColor: ColorConstants.white,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme(
      {Color highlightColor = ColorConstants.green,
      ThemeColor themeColor = ThemeColor.Dark}) {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: Colors.white,
      primaryColor: ColorConstants.white,
      primaryColorDark: getPrimaryColorDark(highlightColor, themeColor),
      backgroundColor: getBackgroundColor(highlightColor, themeColor),
      highlightColor: highlightColor,
      scaffoldBackgroundColor: ColorConstants.black,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static Color getPrimaryColorDark(Color color, ThemeColor themeColor) {
    if (themeColor == ThemeColor.Dark) {
      return color;
    }

    String colorStr = color.toString().toLowerCase().substring(10, 16);

    if (colorStr.toUpperCase() == '6EBCB7') {
      return ColorConstants.lightThemeDarkGreen;
    } else if (colorStr.toUpperCase() == '3FC0F3') {
      return ColorConstants.lightThemeDarkBlue;
    } else {
      return color;
    }
  }

  static Color getBackgroundColor(Color color, ThemeColor themeColor) {
    String colorStr = color.toString().toLowerCase().substring(10, 16);

    if (colorStr.toUpperCase() == 'BB86FC') {
      return color.withOpacity(0.3);
    } else if (colorStr == '3FC0F3') {
      return color.withOpacity(0.05);
    } else if (colorStr == 'A77D60') {
      return color.withOpacity(0.05);
    } else if (colorStr == 'C47E61') {
      return color.withOpacity(0.05);
    } else {
      return color.withOpacity(0.1);
    }
  }
}
