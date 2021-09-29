import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopFeaturedModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];

  List<String> get fields => _fields;

  DesktopFeaturedModel({required this.userPreview}) {
    fetchBasicData();
  }

  void fetchBasicData() {
    _fields.clear();
    var fields = <String>[];
    fields = [
      ...FieldNames().getFieldList(AtCategory.FEATURED, isPreview: true)
    ];
    updateField(fields);
    notifyListeners();
  }

  void updateField(List<String> fields) {
    _fields.clear();
    _fields = fields;
    notifyListeners();
  }
}
