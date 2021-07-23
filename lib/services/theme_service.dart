import 'package:at_commons/at_commons.dart';
import 'package:at_wavi_app/services/backend_service.dart';
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
        print('error in get ${e.errorCode} ${e.errorMessage}');
      });

      // print('getThemePreference result $result');

      return result.value;
    } catch (e) {
      print('getThemePreference throws exception $e');
      return '';
    }
  }

  // deletePreviousKeys() async {
  //   var _metaData = Metadata()
  //     ..isPublic = true
  //     ..ccd = true

  //     /// TODO: true or false
  //     ..namespaceAware = false
  //     ..isEncrypted = false;

  //   var _atKey = AtKey()..metadata = _metaData;

  //   if (true) {
  //     _atKey.key = 'THEME_PREFERENCE' + '.me';
  //   } else {
  //     _atKey.key = AtKeyConstants.highlightColorPreference;
  //     // _value = highlightColor.toString();
  //   }

  //   // var response = await BackendService().atClientInstance.getKeys(
  //   //       regex: 'THEME_PREFERENCE' + '.me',
  //   //     );
  //   // var atKey = AtKey.fromString(response[0]);
  //   // atKey.metadata!.ttr = -1;

  //   var result = await BackendService().atClientInstance.delete(_atKey);
  //   print(' is deleted ? $result');

  //   // var response2 = await BackendService().atClientInstance.getKeys(
  //   //       regex: 'HIGHLIGHT_COLOR_PREFERENCE' + '.me',
  //   //     );
  //   // var atKey2 = AtKey.fromString(response2[0]);
  //   // atKey2.metadata!.ttr = -1;

  //   // var result2 = await BackendService().atClientInstance.delete(atKey2);
  //   // print(' is deleted ? $result');
  // }
}
