import 'package:at_wavi_app/model/basic_data_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/cupertino.dart';

class DesktopProfileMediaModel extends ChangeNotifier {
  final bool isMyProfile;
  final UserPreview userPreview;
  final UserProvider userProvider;
  final AtCategory atCategory;

  List<BasicData> _mediaFields = [];

  List<BasicData> get mediaFields => _mediaFields;

  bool get isEmptyData {
    return mediaFields.isEmpty;
  }

  DesktopProfileMediaModel({
    required this.isMyProfile,
    required this.userPreview,
    required this.userProvider,
    required this.atCategory,
  }) {
    try {
      fetchBasicData();
    } catch (e) {}
  }

  void fetchBasicData() {
    User? user;
    if (isMyProfile) {
      user = userPreview.user();
    } else {
      user = userProvider.user;
    }
    _mediaFields.clear();
    List<BasicData>? customFields = user?.customFields[atCategory.name] ?? [];
    _mediaFields.addAll(customFields);

    notifyListeners();
  }

  void deleteData(BasicData basicData) {
    UserPreview().deletCustomField(atCategory, basicData);
    fetchBasicData();
  }
}
