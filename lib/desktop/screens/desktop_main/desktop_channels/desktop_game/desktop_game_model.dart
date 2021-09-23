import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopGameModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  static const _defaultGames = [
    'PS4',
    'Xbox',
    'Twitch',
  ];

  DesktopGameModel({required this.userPreview}) {
    initFields();
  }

  Future initFields() async {
    var savedFields = await getListStringFromSharedPreferences(
      key: MixedConstants.GAME_KEY,
    );

    var listBasicData;
    if (savedFields == null || savedFields.isEmpty) {
      listBasicData = _defaultGames
          .map(
            (e) => BasicData(
              value: e,
              accountName: e,
              valueDescription: '${_defaultGames.indexOf(e) + 1}. $e',
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
      key: MixedConstants.GAME_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future updateField(List<BasicData> fields) async {
    _fields.clear();
    _fields = fields;

    await saveListStringToSharedPreferences(
      key: MixedConstants.GAME_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }

  Future reorderField(List<String> fields) async {
    _fields = sortBasicData(_fields, fields);
    await saveListStringToSharedPreferences(
      key: MixedConstants.GAME_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
    notifyListeners();
  }
}
