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
  ThemeData darktheme = Themes.darkTheme();
  ThemeData lighttheme = Themes.lightTheme();
  ThemeData? currentAtsignThemeData;
  Color? highlightColor;

  ThemeProvider();

  resetThemeData() {
    reset(SET_THEME);
    currentAtsignThemeData = null;
    highlightColor = null;
  }

  setHighlightColor(Color _color) {
    darktheme = Themes.darkTheme(highlightColor: _color);
    lighttheme = Themes.lightTheme(highlightColor: _color);
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
          : ColorConstants.peach;

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
          this.themeColor = ThemeColor.Dark;
        } else {
          currentAtsignThemeData = lighttheme;
          this.themeColor = ThemeColor.Light;
        }
        setStatus(SET_THEME, Status.Done);
      } else {
        setStatus(SET_THEME, Status.Error);
      }
    }
  }

  convertToHighlightColor(String _color) {
    switch (_color.toLowerCase()) {
      case 'purple':
        return ColorConstants.purple;
      case 'peach':
        return ColorConstants.peach;
      case 'blue':
        return ColorConstants.blue;
      case 'pink':
        return ColorConstants.solidPink;
      case 'brown':
        return ColorConstants.fadedBrown;
      case 'orange':
        return ColorConstants.solidOrange;
      case 'green':
        return ColorConstants.solidLightGreen;
      case 'yellow':
        return ColorConstants.solidYellow;
      default:
        return ColorConstants.peach;
    }
  }
}

enum ThemeColor { Light, Dark }
