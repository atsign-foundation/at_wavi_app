import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopDetailsModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];

  List<String> get fields => _fields;

  static const _defaultDetails = [
    'Media',
    'Basic Details',
    'Additional Details',
    'Location',
  ];

  DesktopDetailsModel({required this.userPreview}) {
    initFields();
  }

  Future initFields() async {
    var savedFields = await getListStringFromSharedPreferences(
      key: MixedConstants.LIST_DETAIL_KEY,
    );
    if (savedFields == null || savedFields.isEmpty) {
      savedFields = [..._defaultDetails];
    }
    await updateField(
      savedFields,
      isInit: true,
    );
  }

  Future updateField(
    List<String> fields, {
    bool isInit = false,
  }) async {
    _fields.clear();
    _fields = fields;

    if (!isInit) {
      await saveListStringToSharedPreferences(
        key: MixedConstants.LIST_DETAIL_KEY,
        value: _fields,
      );
    }
    notifyListeners();
  }
}
