import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopReorderAdditionalDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];

  List<String> get fields => _fields;

  DesktopReorderAdditionalDetailModel({required this.userPreview}) {
    FieldOrderService().initCategoryFields(AtCategory.ADDITIONAL_DETAILS);
    fetchFields();
  }

  void fetchFields() {
    _fields = [
      ...FieldNames().getFieldList(AtCategory.ADDITIONAL_DETAILS, isPreview: true)
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
    FieldOrderService().updateField(AtCategory.ADDITIONAL_DETAILS, fields);
    Navigator.of(context).pop('saved');
  }
}
