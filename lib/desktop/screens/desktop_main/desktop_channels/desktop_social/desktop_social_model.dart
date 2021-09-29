import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopSocialModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<BasicData> _fields = [];

  List<BasicData> get fields => _fields;

  DesktopSocialModel({required this.userPreview}) {
    try {
      FieldOrderService().initCategoryFields(AtCategory.SOCIAL);
      fetchBasicData();
    } catch (e) {}
  }

  void fetchBasicData() {
    _fields.clear();
    var userMap = User.toJson(userPreview.user());
    List<BasicData>? customFields =
        userPreview.user()?.customFields[AtCategory.SOCIAL.name] ?? [];

    var fields = <String>[];
    fields = [
      ...FieldNames().getFieldList(AtCategory.SOCIAL, isPreview: true)
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

  Future addField() async {
    fetchBasicData();
  }

  void updateValues(int index, String value) {
    _fields[index].value = value;
  }

  Future saveAndPublish() async {
    await saveListStringToSharedPreferences(
      key: MixedConstants.SOCIAL_KEY,
      value: _fields.map((e) => e.toJson() as String).toList(),
    );
  }
}
