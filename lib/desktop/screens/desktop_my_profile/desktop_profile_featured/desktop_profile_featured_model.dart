import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopProfileFeaturedModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];

  List<String> get fields => _fields;

  DesktopProfileFeaturedModel({required this.userPreview}) {
    fetchBasicData();
  }

  // void fetchBasicData() {
  //   _fields.clear();
  //   var fields = <String>[];
  //   fields = [
  //     ...FieldNames().getFieldList(AtCategory.FEATURED, isPreview: true)
  //   ];
  //   updateField(fields);
  //   notifyListeners();
  // }

  void fetchBasicData() {
    _fields.clear();
    var userMap = User.toJson(userPreview.user());
    List<BasicData>? customFields =
        userPreview.user()?.customFields[AtCategory.SOCIAL.name] ?? [];

    var fields = <String>[];
    fields = [...FieldNames().getFieldList(AtCategory.SOCIAL)];

    // for (int i = 0; i < fields.length; i++) {
    //   BasicData basicData = BasicData();
    //   bool isCustomField = false;

    //   if (userMap.containsKey(fields[i])) {
    //     basicData = userMap[fields[i]];
    //     if (basicData.accountName == null) basicData.accountName = fields[i];
    //     if (basicData.value == null) basicData.value = '';
    //   } else {
    //     var index =
    //         customFields.indexWhere((el) => el.accountName == fields[i]);
    //     if (index != -1) {
    //       basicData = customFields[index];
    //       isCustomField = true;
    //     }
    //   }
    //   if (basicData.value != null && basicData.value.isNotEmpty) {
    //     _fields.add(basicData.accountName!);
    //   }
    // }
    notifyListeners();
  }

  void updateField(List<String> fields) {
    _fields.clear();
    _fields = fields;
    notifyListeners();
  }
}
