import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  List<String> _values = [];

  List<String> get values => _values;

  static const _defaultBasicDetails = [
    'Phone',
    'Email',
  ];

  DesktopBasicDetailModel({required this.userPreview}) {
    initFields();
  }

  Future initFields() async {
    var savedFields = await getListStringFromSharedPreferences(
      key: MixedConstants.BASIC_DETAILS_KEY,
    );

    var listBasicData;
    if (savedFields == null || savedFields.isEmpty) {
      listBasicData = _defaultBasicDetails
          .map(
            (e) => BasicData(
              value: e,
              accountName: e,
              valueDescription: '${_defaultBasicDetails.indexOf(e) + 1}. $e',
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

    for (int i = 0; i < listBasicData.length; i++) {
      _values.add(listBasicData[i].valueDescription);
    }

    await updateField(
      listBasicData,
    );
  }

  Future addField(BasicData newField) async {
    _fields.add(newField);
    await saveListStringToSharedPreferences(
      key: MixedConstants.BASIC_DETAILS_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future updateField(List<BasicData> fields) async {
    _fields.clear();
    _fields = fields;

    await saveListStringToSharedPreferences(
      key: MixedConstants.BASIC_DETAILS_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future reorderField(List<String> fields) async {
    _fields = sortBasicData(_fields, fields);
    await saveListStringToSharedPreferences(
      key: MixedConstants.BASIC_DETAILS_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  void updateValues(int index, String value) {
    _fields[index].valueDescription = value;
  }

  Future saveAndPublish() async {
    await saveListStringToSharedPreferences(
      key: MixedConstants.BASIC_DETAILS_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
  }
}