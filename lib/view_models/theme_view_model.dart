import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/theme_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'base_model.dart';

class ThemeProvider extends BaseModel {
  // ignore: non_constant_identifier_names
  String SET_THEME = 'set_theme';

  ThemeColor themeColor = ThemeColor.Light;
  ThemeData darktheme = Themes.darkTheme(ColorConstants.purple);
  ThemeData lighttheme = Themes.lightTheme(ColorConstants.purple);
  ThemeData? currentAtsignThemeData;
  Color? highlightColor;

  ThemeProvider();

  setHighlightColor(Color _color) {
    darktheme = Themes.darkTheme(_color);
    lighttheme = Themes.lightTheme(_color);
    highlightColor = _color;
    currentAtsignThemeData =
        (themeColor == ThemeColor.Light) ? lighttheme : darktheme;
  }

  Future<ThemeData> getTheme() async {
    await checkThemeFromSecondary(notifyListener: false);
    return currentAtsignThemeData!;
  }

  // ignore: always_declare_return_types
  checkThemeFromSecondary({bool notifyListener = true}) async {
    if (currentAtsignThemeData == null) {
      var _themePreference = await ThemeService()
          .getThemePreference(BackendService().atClientInstance.currentAtSign!);

      if ((_themePreference ?? '').toLowerCase() == 'dark') {
        currentAtsignThemeData = darktheme;
        themeColor = ThemeColor.Dark;
      } else {
        currentAtsignThemeData = lighttheme;
        themeColor = ThemeColor.Light;
      }
    }

    if (highlightColor == null) {
      var _highlightColorPreference = await ThemeService().getThemePreference(
          BackendService().atClientInstance.currentAtSign!,
          returnHighlightColorPreference: true);

      highlightColor = (_highlightColorPreference != null)
          ? convertToHighlightColor(_highlightColorPreference)
          : ColorConstants.purple;

      // theme.highlightColor = highlightColor!;
      setHighlightColor(highlightColor!);
    }

    if (notifyListener) {
      notifyListeners();
    }
  }

  // ignore: always_declare_return_types
  setTheme({ThemeColor? themeColor, Color? highlightColor}) async {
    setStatus(SET_THEME, Status.Loading);

    if (highlightColor != null) {
      var _res =
          await ThemeService().updateProfile(highlightColor: highlightColor);
      if (_res) {
        setHighlightColor(highlightColor);
        setStatus(SET_THEME, Status.Done);
      } else {
        setStatus(SET_THEME, Status.Error);
      }
    }

    if (themeColor != null) {
      var _res =
          await ThemeService().updateProfile(themePreference: themeColor);
      if (_res) {
        if (themeColor == ThemeColor.Dark) {
          currentAtsignThemeData = darktheme;
          themeColor = ThemeColor.Dark;
        } else {
          currentAtsignThemeData = lighttheme;
          themeColor = ThemeColor.Light;
        }
        setStatus(SET_THEME, Status.Done);
      } else {
        setStatus(SET_THEME, Status.Error);
      }
    }
  }

  convertToHighlightColor(String _color) {
    switch (_color.toUpperCase()) {
      case '58419C':
        return ColorConstants.purple;
      case '6EBCB7':
        return ColorConstants.peach;
      case '0455BF':
        return ColorConstants.blue;
      case 'FE1094':
        return ColorConstants.solidPink;
      case 'A77D60':
        return ColorConstants.fadedBrown;
      case 'EF5743':
        return ColorConstants.solidOrange;
      case '7CCB12':
        return ColorConstants.solidLightGreen;
      case 'FFBE21':
        return ColorConstants.solidYellow;
      default:
        return ColorConstants.purple;
    }
  }
}

enum ThemeColor { Light, Dark }
