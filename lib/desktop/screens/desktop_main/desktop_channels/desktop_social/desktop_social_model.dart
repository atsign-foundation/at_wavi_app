import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopSocialModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  static const _defaultSocials = [
    'Facebook',
    'Instagram',
    'Twitter',
  ];

  DesktopSocialModel({required this.userPreview}) {
    initFields();
  }

  Future initFields() async {
    var savedFields = await getListStringFromSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
    );

    var listBasicData;
    if (savedFields == null || savedFields.isEmpty) {
      listBasicData = _defaultSocials
          .map(
            (e) => BasicData(
              value: e,
              accountName: e,
              valueDescription: '${_defaultSocials.indexOf(e) + 1}. $e',
            ),
          )
          .toList();
    } else {
      listBasicData = savedFields
          .map(
            (e) => BasicData.fromJson(
              json.decode(e),
            ),
          )
          .toList();
    }
    await updateField(listBasicData);
  }

  Future addField(BasicData newField) async {
    _fields.add(newField);
    await saveListStringToSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future updateField(List<BasicData> fields) async {
    _fields.clear();
    _fields = fields;

    await saveListStringToSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future reorderField(List<String> fields) async {
    _fields = sortBasicData(_fields, fields);
    await saveListStringToSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  void updateValues(int index, String value) {
    _fields[index].valueDescription = value;
  }

  Future saveAndPublish() async {
    await saveListStringToSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
  }
}
