import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopReorderBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;
  final AtCategory atCategory;

  List<String> _fields = [];

  List<String> get fields => _fields;

  DesktopReorderBasicDetailModel({
    required this.userPreview,
    required this.atCategory,
  }) {
    FieldOrderService().initCategoryFields(atCategory);
    fetchFields();
  }

  void fetchFields() {
    _fields = [
      ...FieldNames().getFieldList(atCategory, isPreview: true)
    ];
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = _fields.removeAt(oldIndex);
    _fields.insert(newIndex, item);
    notifyListeners();
  }

  void saveData(BuildContext context) {
    FieldOrderService().updateField(atCategory, fields);
    Navigator.of(context).pop('saved');
  }
}
