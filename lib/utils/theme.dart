import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themes {
  Themes._();
  static final Themes _instance = Themes._();
  factory Themes() => _instance;
  static Color highlightColor = ColorConstants.purple;

  // ignore: non_constant_identifier_names
  ThemeData PRIMARY_THEME = ThemeData(
    primaryColor: ColorConstants.white,
    fontFamily: 'HelveticaNeu',
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static Color setHighlightColor(Color _highlightColor) {
    Provider.of<ThemeProvider>(NavService.navKey.currentContext!, listen: false)
        .storeHexHighlightColor(_highlightColor.toString());
    return highlightColor = _highlightColor;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorConstants.black,
      highlightColor: highlightColor,
      // hintColor: AllColors().DARK_GREY,
      // textTheme: TextTheme(
      //   subtitle1: TextStyle(color: AllColors().DARK_GREY, fontSize: 12),
      //   subtitle2: TextStyle(color: AllColors().DARK_GREY, fontSize: 10),
      //   bodyText1: TextStyle(color: AllColors().DARK_GREY, fontSize: 16),
      //   bodyText2: TextStyle(color: AllColors().DARK_GREY, fontSize: 14),
      //   headline1: TextStyle(
      //       color: AllColors().Black,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline2: TextStyle(
      //       color: AllColors().ORANGE,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline3: TextStyle(color: AllColors().GREY, fontSize: 16),
      //   headline4: TextStyle(color: AllColors().GREY, fontSize: 14),
      //   headline5: TextStyle(color: AllColors().GREY, fontSize: 12),
      // ),
      // primaryTextTheme: TextTheme(
      //   headline1: TextStyle(
      //       color: AllColors().Black,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline2: TextStyle(color: AllColors().Black, fontSize: 16),
      //   headline3: TextStyle(color: AllColors().Black, fontSize: 14),
      //   headline4: TextStyle(color: AllColors().Black, fontSize: 12),
      //   headline5: TextStyle(color: AllColors().Black, fontSize: 10),
      // ),
      // iconTheme: IconThemeData(color: AllColors().Black),
      // appBarTheme: AppBarTheme(
      //     color: AllColors().WHITE,
      //     iconTheme: IconThemeData(color: AllColors().Black),
      //     textTheme: TextTheme(
      //         headline1: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w700,
      //             color: AllColors().Black),
      //         headline2: TextStyle(
      //             fontSize: 15,
      //             fontWeight: FontWeight.w700,
      //             color: AllColors().WHITE))),
      scaffoldBackgroundColor: ColorConstants.white,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorConstants.white,
      highlightColor: highlightColor,
      // hintColor: AllColors().DARK_GREY,
      // textTheme: TextTheme(
      //   subtitle1: TextStyle(color: AllColors().DARK_GREY, fontSize: 12),
      //   subtitle2: TextStyle(color: AllColors().DARK_GREY, fontSize: 10),
      //   bodyText1: TextStyle(color: AllColors().DARK_GREY, fontSize: 16),
      //   bodyText2: TextStyle(color: AllColors().DARK_GREY, fontSize: 14),
      //   headline1: TextStyle(
      //       color: AllColors().LIGHT_GREY,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline2: TextStyle(
      //       color: AllColors().ORANGE,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline3: TextStyle(color: AllColors().GREY, fontSize: 16),
      //   headline4: TextStyle(color: AllColors().GREY, fontSize: 14),
      //   headline5: TextStyle(color: AllColors().GREY, fontSize: 12),
      // ),
      // primaryTextTheme: TextTheme(
      //   headline1: TextStyle(
      //       color: AllColors().WHITE,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700),
      //   headline2: TextStyle(color: AllColors().WHITE, fontSize: 16),
      //   headline3: TextStyle(color: AllColors().WHITE, fontSize: 14),
      //   headline4: TextStyle(color: AllColors().WHITE, fontSize: 12),
      //   headline5: TextStyle(color: AllColors().WHITE, fontSize: 10),
      // ),
      // iconTheme: IconThemeData(color: AllColors().WHITE),
      // appBarTheme: AppBarTheme(
      //     color: AllColors().Black,
      //     iconTheme: IconThemeData(color: AllColors().WHITE),
      //     textTheme: TextTheme(
      //         headline1: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w700,
      //             color: AllColors().WHITE),
      //         headline2: TextStyle(
      //             fontSize: 15,
      //             fontWeight: FontWeight.w700,
      //             color: AllColors().WHITE))),
      scaffoldBackgroundColor: ColorConstants.black,
      fontFamily: 'HelveticaNeu',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData getThemeData(ThemeColor _themeColor) {
    if (_themeColor == ThemeColor.Dark) {
      return Themes.darkTheme;
    } else {
      return Themes.lightTheme;
    }
  }
}

isDarkModeEnabled(BuildContext _context) {
  if (Theme.of(_context).scaffoldBackgroundColor ==
      Themes.darkTheme.scaffoldBackgroundColor) {
    return true;
  }

  return false;
}
