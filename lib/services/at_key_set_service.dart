import 'dart:convert';

import 'package:at_base2e15/at_base2e15.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:provider/provider.dart';

import 'at_key_get_service.dart';
import 'nav_service.dart';

class AtKeySetService {
  AtKeySetService._();
  static AtKeySetService _instance = AtKeySetService._();
  factory AtKeySetService() => _instance;

  /// Example for update() => Will update FirstName
  // AtKeySetService().update(
  // BasicData(
  //   value: 'Ntsh',
  // ),
  // FieldsEnum.FIRSTNAME.name);

  /// Returns true if the field gets updated in secondary successfully.
  Future<bool> update(BasicData data, String key,
      {bool? isCheck = true, List<AtKey>? scanKeys}) async {
    var result;
    key = key.trim().toLowerCase().replaceAll(' ', '');
    String? sharedWith = data.isPrivate
        ? BackendService().atClientInstance.currentAtSign!
        : null;
    var value = data.value;
    if (value?.isEmpty && isCheck == null) {
      return true;
    }
    var metaData = Metadata();
    metaData.isPublic = !data.isPrivate;
    metaData.isEncrypted = data.isPrivate;
    if (key == FieldsEnum.IMAGE.name) {
      metaData.isBinary = true;
    }
    var atKey = AtKey()
      ..key = key
      ..sharedWith = sharedWith
      ..metadata = metaData;
    //updates only changed key and deletes previous key if public status is changed.
    if (isCheck != null) {
      if (scanKeys == null) {
        scanKeys = await BackendService().atClientInstance.getAtKeys();
      }
      var isDeleted = await _deleteChangedKeys(atKey, scanKeys);
      if (value.isEmpty) {
        // _tempObject.remove(key.split('.')[0]);
        return await BackendService().atClientInstance.delete(atKey);
      }
      if (isDeleted == null) {
        /// If revious value is same as new value then dont update
        var notUpdate = _checkCriteria(key.split('.')[0], data.value);
        if (notUpdate) {
          return true;
        }
      }
    }
    result = await BackendService().atClientInstance.put(atKey, value);
    return result;
  }

  ///Returns `true` if tempObject's value for [key] is equal to [value].
  bool _checkCriteria(dynamic key, var value) {
    // return _tempObject.containsKey(key) ? _tempObject[key] == value : false;
    // / check if this value is same as the previous value
    return false;
  }

  ///deletes old key for atKey if public status is changed.
  Future<bool> _deleteChangedKeys(AtKey atKey, List<AtKey> atKeys) async {
    var response;
    List<AtKey> tempScanKeys = [];
    tempScanKeys.addAll(atKeys);

    tempScanKeys.retainWhere((scanKey) => scanKey.key == atKey.key
        //  && !scanKey.metadata.isPublic == atKey.metadata!.isPublic
        );
    print('tempScanKeys.length: ${tempScanKeys.length}');
    if (tempScanKeys.isNotEmpty) {
      await Future.forEach(tempScanKeys, (element) async {
        response =
            await BackendService().atClientInstance.delete(element! as AtKey);
      });
    }
    return response ?? false;
  }

  /// Example for updateCustomFields() => Will create custom_testing.wavi key with label = 'Testing
  /// value = 'This is coming from new wavi app', and category = 'DETAILS'
  ///
  // AtKeySetService().updateCustomFields(
  //     AtCategory.DETAILS.name, // gives 'DETAILS'
  //     [
  //       BasicData(
  //           value: 'This is coming from new wavi app',
  //           accountName: 'Testing',
  //           type: CustomContentType.Text.name)
  //     ],
  //   );

  /// Could only access => GAMER, SOCIAL & DETAILS. from previous app.

  /// category => BASIC_DETAILS, ADDITIONAL_DETAILS, LOCATION, SOCIAL_CHANNEL, GAME_CHANNEL, FEATURED_CHANNEL
  /// category = screen name, later also gets stored as category in json
  /// Returns true on succesfully updating custom fields in secondary.
  Future<bool> updateCustomFields(String category, List<BasicData> value,
      {bool? isCheck = true, var scanKeys}) async {
    var result;
    for (var data in value) {
      String accountname = _formatCustomTitle(data.accountName ?? '');
      String key = AtText.CUSTOM + '_' + accountname;
      String? sharedWith = data.isPrivate
          ? BackendService().atClientInstance.currentAtSign
          : null;
      String jsonValue = _encodeToJsonString(data, category);
      var metadata = Metadata()
        ..isPublic = !data.isPrivate
        ..isEncrypted = data.isPrivate;
      var atKey = AtKey()
        ..key = key.contains(AtText.IS_DELETED)
            ? key.replaceAll(AtText.IS_DELETED, '')
            : key.replaceAll(' ', '')
        ..sharedWith = sharedWith
        ..metadata = metadata;
      if (data.value == null && isCheck == null) {
        continue;
      }
      if (isCheck != null) {
        if (scanKeys == null) {
          scanKeys = await BackendService().atClientInstance.getAtKeys();
        }
        var isDeleted = await _deleteChangedKeys(atKey, scanKeys);
        // if (!atKey.metadata!.isPublic!) {
        //   await BackendService().atClientInstance.delete(atKey);
        // }
        // print('isDeleted $isDeleted');
        if (data.value == null) {
          // _tempObject.remove(key.split('.')[0]);
          result = await BackendService().atClientInstance.delete(atKey);
          if (!result) return result;
          continue;
        }
        if (isDeleted == null) {
          var notUpdate = _checkCriteria(key, jsonValue);
          if (notUpdate) {
            continue;
          }
        }
      }

      result = await BackendService().atClientInstance.put(atKey, jsonValue);
      if (result == false) {
        return result;
      }
    }

    /// Will update user provider
    if (result) {
      var _providerUser = (Provider.of<UserProvider>(
                  NavService.navKey.currentContext!,
                  listen: false)
              .user!
              .customFields[category] ??
          []);
      for (var i = 0; i < _providerUser.length; i++) {
        for (int j = 0; j < value.length; j++) {
          if (_providerUser[i].accountName == value[j].accountName) {
            _providerUser[i] = value[j];
            break;
          }
        }
      }
      Provider.of<UserProvider>(NavService.navKey.currentContext!,
              listen: false)
          .notify();
    }
    return result ??= true;
  }

  ///Returns jsonString of [basicData].
  String _encodeToJsonString(BasicData basicData, String screenName) {
    var value = {};
    value[CustomFieldConstants.label] = basicData.accountName;
    value[CustomFieldConstants.category] = screenName.toUpperCase();
    value[CustomFieldConstants.type] = basicData.type;
    value[CustomFieldConstants.value] = basicData.value;
    value[CustomFieldConstants.valueDescription] = basicData.valueDescription;
    value = _setCustomContentValue(type: basicData.type, json: value);
    String json = jsonEncode(value);
    return json;
  }

  ///returns [json] by modifying the value based on [type].
  _setCustomContentValue({required var type, required var json}) {
    json[CustomFieldConstants.valueLabel] = '';
    if (type == CustomContentType.Image.name) {
      json[CustomFieldConstants.value] =
          Base2e15.encode(json[CustomFieldConstants.value]);
      return json;
    } else if (type == CustomContentType.Youtube.name) {
      json[CustomFieldConstants.valueLabel] = json[CustomFieldConstants.value];
      var match = RegExp(AtText.YOUTUBE_PATTERN)
          .firstMatch(json[CustomFieldConstants.value].toString());
      if (match != null && match.groupCount >= 1) {
        json[CustomFieldConstants.value] = match.group(1);
      }
      return json;
    } else {
      return json;
    }
  }

  ///Replaces sepcial characters with '_'.
  String _formatCustomTitle(String data) {
    return data.trim().toLowerCase().replaceAll(RegExp(r'(:|@|;|\?|!|,)'), '_');
  }
}
