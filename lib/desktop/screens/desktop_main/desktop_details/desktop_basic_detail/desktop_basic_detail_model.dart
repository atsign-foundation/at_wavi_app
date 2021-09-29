import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  List<String> _values = [];

  List<String> get values => _values;

  DesktopBasicDetailModel({required this.userPreview}) {
    try {
      FieldOrderService().initCategoryFields(AtCategory.DETAILS);
      fetchBasicData();
    } catch (e) {}
  }

  void fetchBasicData() {
    _fields.clear();
    var userMap = User.toJson(userPreview.user());
    List<BasicData>? customFields =
        userPreview.user()?.customFields[AtCategory.DETAILS.name] ?? [];

    var fields = <String>[];
    fields = [
      ...FieldNames().getFieldList(AtCategory.DETAILS, isPreview: true)
    ];

    for (int i = 0; i < fields.length; i++) {
      BasicData basicData = BasicData();
      bool isCustomField = false;

      if (userMap.containsKey(fields[i])) {
        basicData = userMap[fields[i]];
        if (basicData.accountName == null) basicData.accountName = fields[i];
        if (basicData.value == null) basicData.value = '';
      } else {
        var index =
            customFields.indexWhere((el) => el.accountName == fields[i]);
        if (index != -1) {
          basicData = customFields[index];
          isCustomField = true;
        }
      }

      if (basicData.accountName == null) {
        continue;
      }
      _fields.add(basicData);
    }
    notifyListeners();
  }

  void saveData(BuildContext context) async {
    Navigator.of(context).pop('saved');
  }

  /// ///////////////////////////////////////////
  Future addField() async {
    fetchBasicData();
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
