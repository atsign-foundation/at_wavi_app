import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;
  final AtCategory atCategory;

  List<BasicData> _basicData = [];

  List<BasicData> get basicData => _basicData;

  DesktopBasicDetailModel({
    required this.userPreview,
    required this.atCategory,
  }) {
    try {
      FieldOrderService().initCategoryFields(atCategory);
      fetchBasicData();
    } catch (e) {

    }
  }

  void fetchBasicData() {
    _basicData.clear();
    var userMap = User.toJson(userPreview.user());
    List<BasicData>? customFields =
        userPreview.user()?.customFields[atCategory] ?? [];

    var fields = <String>[];
    fields = [
      ...FieldNames().getFieldList(atCategory, isPreview: true)
    ];

    for (int i = 0; i < fields.length; i++) {
      bool isCustomField = false;
      BasicData basicData = BasicData();

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
      _basicData.add(basicData);
    }
    notifyListeners();
  }
}
