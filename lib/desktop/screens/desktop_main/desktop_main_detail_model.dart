import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopMainDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];
  List<String> get fields => _fields;

  DesktopMainDetailModel({required this.userPreview}) {
    updateField(_fields);
  }

  void updateField(List<String> fields) {
    _fields.clear();
    _fields = fields;
    notifyListeners();
  }
}
