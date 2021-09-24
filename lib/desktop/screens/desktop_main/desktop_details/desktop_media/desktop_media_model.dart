import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopMediaModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  static const _defaultMedias = [];

  DesktopMediaModel({required this.userPreview}) {
    initFields();
  }

  Future addMedia(BasicData newMedia) async {
    _fields.add(newMedia);
    await saveListStringToSharedPreferences(
      key: MixedConstants.MEDIA_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future initFields() async {
    var savedFields = await getListStringFromSharedPreferences(
      key: MixedConstants.MEDIA_KEY,
    );

    List<BasicData> listBasicData;
    if (savedFields == null || savedFields.isEmpty) {
      listBasicData = [];
    } else {
      listBasicData = savedFields
          .map(
            (e) => BasicData.fromJson(
              json.decode(e),
            ),
          )
          .toList();
    }

    await updateField(
      listBasicData,
    );
  }

  Future updateField(List<BasicData> fields) async {
    _fields.clear();
    _fields = fields;

    await saveListStringToSharedPreferences(
      key: MixedConstants.MEDIA_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future reorderField(List<String> fields) async {
    _fields = sortBasicData(_fields, fields);
    await saveListStringToSharedPreferences(
      key: MixedConstants.MEDIA_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }
}
