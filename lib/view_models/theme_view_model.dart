import 'package:at_wavi_app/data_services/hive/hive_db.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/theme_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'base_model.dart';

class ThemeProvider extends BaseModel {
  ThemeColor themeColor;
  late HiveDataProvider _hiveDataProvider;
  bool isDark = false;

  ThemeProvider({required this.themeColor}) {
    _hiveDataProvider = HiveDataProvider();
    // checkTheme();
    Hive.initFlutter();
  }

  /// checks in hive
  checkTheme() async {
    ThemeColor _currentTheme;
    var res = await _hiveDataProvider.readData('theme');

    Themes.highlightColor = (res['highlight_color'] != null)
        ? setHighlightColor(res['highlight_color'])
        : ColorConstants.purple;

    if (res['theme_color'] == 'ThemeColor.Dark') {
      _currentTheme = ThemeColor.Dark;
      isDark = true;
    } else {
      isDark = false;
      _currentTheme = ThemeColor.Light;
    }

    return _currentTheme;
  }

  // ignore: always_declare_return_types
  checkThemeFromSecondary() async {
    ThemeColor _currentTheme;
    var _themePreference = await ThemeService()
        .getThemePreference(BackendService().atClientInstance.currentAtSign!);

    if ((_themePreference ?? '').toLowerCase() == 'dark') {
      _currentTheme = ThemeColor.Dark;
      isDark = true;
    } else {
      isDark = false;
      _currentTheme = ThemeColor.Light;
    }

    var _highlightColorPreference = await ThemeService().getThemePreference(
        BackendService().atClientInstance.currentAtSign!,
        returnHighlightColorPreference: true);

    Themes.highlightColor = (_highlightColorPreference != null)
        ? setHighlightColor(_highlightColorPreference)
        : ColorConstants.purple;

    notifyListeners();

    return _currentTheme;
  }

  // ignore: always_declare_return_types
  setTheme({ThemeColor? themeColor, Color? highlightColor}) async {
    if (highlightColor != null) {
      await ThemeService().updateProfile(highlightColor: highlightColor);
      Themes.setHighlightColor(highlightColor);
    }

    if (themeColor != null) {
      await ThemeService().updateProfile(themePreference: themeColor);
      await _hiveDataProvider
          .insertData('theme', {'theme_color': themeColor.toString()});

      this.themeColor = themeColor;
      isDark = themeColor == ThemeColor.Dark ? true : false;
    }
    notifyListeners();

    // await Hive.initFlutter();

    // notifyListeners();
  }

  storeHexHighlightColor(String color) async {
    // await Hive.initFlutter();
    await _hiveDataProvider.insertData(
        'theme', {'highlight_color': color.toUpperCase().toString()});
  }

  ThemeColor get getTheme => themeColor;

  setHighlightColor(String _color) {
    switch (_color.toUpperCase()) {
      case 'COLOR(0XFF58419C)':
        return ColorConstants.purple;
      case 'COLOR(0XFF6EBCB7)':
        return ColorConstants.peach;
      case 'COLOR(0XFF0455BF)':
        return ColorConstants.blue;
      case 'COLOR(0XFFFE1094)':
        return ColorConstants.solidPink;
      case 'COLOR(0XFFA77D60)':
        return ColorConstants.fadedBrown;
      case 'COLOR(0XFFEF5743)':
        return ColorConstants.solidOrange;
      case 'COLOR(0XFF7CCB12)':
        return ColorConstants.solidLightGreen;
      case 'COLOR(0XFFFFBE21)':
        return ColorConstants.solidYellow;
      default:
        return ColorConstants.purple;
    }
  }
}

enum ThemeColor { Light, Dark }
