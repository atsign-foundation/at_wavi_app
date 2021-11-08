import 'package:at_wavi_app/model/basic_data_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/cupertino.dart';

class DesktopBasicDetailModel extends ChangeNotifier {
  final bool isMyProfile;
  final UserPreview userPreview;
  final UserProvider userProvider;
  final AtCategory atCategory;

  List<BasicDataModel> _basicData = [];

  List<BasicDataModel> get basicData => _basicData;

  BasicData? _locationData;

  BasicData? get locationData => _locationData;
  BasicData? _locationNicknameData;

  BasicData? get locationNicknameData => _locationNicknameData;

  bool get isEmptyData {
    bool isEmpty = true;
    basicData.forEach((element) {
      final value = element.data.value;
      if (value is String) {
        if (value.isNotEmpty) {
          isEmpty = false;
        }
      } else if (value != null) {
        isEmpty = false;
      }
    });
    return isEmpty;
  }

  DesktopBasicDetailModel({
    required this.isMyProfile,
    required this.userPreview,
    required this.userProvider,
    required this.atCategory,
  }) {
    try {
      FieldOrderService().initCategoryFields(atCategory);
      fetchBasicData();
      //
    } catch (e) {}
  }

  void fetchBasicData() {
    User? user;
    if (isMyProfile) {
      user = userPreview.user();
    } else {
      user = userProvider.user;
    }
    _basicData.clear();
    var userMap = User.toJson(user);
    List<BasicData>? customFields = user?.customFields[atCategory.name] ?? [];

    var fields = <String>[];
    fields = [...FieldNames().getFieldList(atCategory, isPreview: true)];

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
      _basicData.add(BasicDataModel(
        data: basicData,
        isCustomField: isCustomField,
      ));
    }
    //
    if (atCategory == AtCategory.LOCATION) {
      _locationNicknameData = user?.locationNickName;
      _locationData = user?.location;
      _basicData.removeWhere((element) {
        return element.data.accountName == _locationNicknameData?.accountName ||
            element.data.accountName == _locationData?.accountName;
      });
    }

    notifyListeners();
  }

  void deleteData(BasicData basicData) {
    UserPreview().deletCustomField(atCategory, basicData);
    fetchBasicData();
  }
}
