import 'package:at_commons/at_commons.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/exception_service.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';

class ThemeService {
  ThemeService._();
  static ThemeService _instance = ThemeService._();
  factory ThemeService() => _instance;

  /// Updates user theme preferences.
  ///
  /// Throws [assertionError] if [themePreference] and [highlightColor] both are null.
  Future<bool> updateProfile(
      {ThemeColor? themePreference, Color? highlightColor}) async {
    try {
      assert(themePreference != null || highlightColor != null);

      late String _value;

      var _metaData = Metadata()
        ..isPublic = true
        ..ccd = true

        /// TODO: true or false
        ..namespaceAware = true
        ..isEncrypted = false;

      var _atKey = AtKey()..metadata = _metaData;

      if (themePreference != null) {
        _atKey.key = AtKeyConstants.themePreference;
        if (themePreference == ThemeColor.Dark) {
          _value = 'dark'.toString();
        } else {
          _value = 'light'.toString();
        }
      } else if (highlightColor != null) {
        _atKey.key = AtKeyConstants.highlightColorPreference;
        _value = highlightColor.toString().toLowerCase().substring(10, 16);
      }

      print('_value $_value');

      var _result = await BackendService().atClientInstance.put(_atKey, _value);
      print('_result $_result');
      return _result;
    } catch (e) {
      ExceptionService.instance.showGetExceptionOverlay(e);
      print('updateProfile throws exception $e');
      return false;
    }
  }

  Future<String?> getThemePreference(String _atsign,
      {bool returnHighlightColorPreference = false}) async {
    try {
      if (!_atsign.contains('@')) {
        _atsign = '@' + _atsign;
      }

      var metadata = Metadata();
      metadata.isPublic = true;
      metadata.namespaceAware = true;

      var key = AtKey();
      key.sharedBy = _atsign;
      key.metadata = metadata;

      key.key = returnHighlightColorPreference
          ? AtKeyConstants.highlightColorPreference
          : AtKeyConstants.themePreference;

      print('key.key ${key.key}');

      var result =
          await BackendService().atClientInstance.get(key).catchError((e) {
        ExceptionService.instance.showGetExceptionOverlay(e);
        print('error in get ${e.errorCode} ${e.errorMessage}');
      });

      // print('getThemePreference result $result');

      return result.value;
    } catch (e) {
      ExceptionService.instance.showGetExceptionOverlay(e);
      print('getThemePreference throws exception $e');
      return '';
    }
  }
}
