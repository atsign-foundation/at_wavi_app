import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/basic_data_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopEditBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;
  final AtCategory atCategory;

  List<BasicDataModel> _basicData = [];

  List<BasicDataModel> get basicData => _basicData;

  DesktopEditBasicDetailModel({
    required this.userPreview,
    required this.atCategory,
  }) {
    try {
      FieldOrderService().initCategoryFields(atCategory);
      fetchBasicData();
    } catch (e) {}
  }

  void fetchBasicData() {
    _basicData.clear();
    var userMap = User.toJson(userPreview.user());
    List<BasicData>? customFields =
        userPreview.user()?.customFields[atCategory.name] ?? [];

    var fields = <String>[];
    fields = [...FieldNames().getFieldList(atCategory, isPreview: true)];

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
      _basicData.add(
        BasicDataModel(
          data: basicData,
          controller: TextEditingController(text: basicData.value),
          isCustomField: isCustomField,
        ),
      );
    }
    notifyListeners();
  }

  void saveData(BuildContext context) async {
    for (var data in _basicData) {
      final newBasicData = data.data;
      newBasicData.value = data.controller?.text.trim();
      await updateDefinedFields(context, newBasicData);
    }
    Navigator.of(context).pop('saved');
  }
}
