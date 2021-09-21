import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopReorderBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<String> _fields = [];

  List<String> get fields => _fields;

  List<String> _previousFields = [];

  List<String> get previousFields => _previousFields;

  AtCategory atCategory;

  static const _basicDetails = [
    'phone',
    'email',
  ];
  static const _additionalDetails = [
    'pronoun',
    'about',
    'quote',
    'video',
  ];
  static const _socialAccounts = [
    'facebook',
    'instagram',
    'twitter',
  ];
  static const _gameFields = [
    'ps4',
    'xbox',
    'twitch',
  ];
  static const _locationFields = [
    'locationnickname',
    'location',
  ];

  List<String> get basicDetailsFields {
    return _basicDetails;
  }

  List<String> get additionalDetailsFields {
    return _additionalDetails;
  }

  List<String> get socialAccountsFields {
    return _socialAccounts;
  }

  List<String> get gameFields {
    return _gameFields;
  }

  DesktopReorderBasicDetailModel({
    required this.userPreview,
    this.atCategory = AtCategory.DETAILS,
  }) {
    //  FieldOrderService().initCategoryFields(atCategory);
    fetchFields(atCategory);
  }

  void fetchFields(AtCategory category) {
    if (category == AtCategory.DETAILS) {
      _fields = [..._basicDetails];
    } else if (category == AtCategory.ADDITIONAL_DETAILS) {
      _fields = [..._additionalDetails];
    } else if (category == AtCategory.SOCIAL) {
      _fields = [..._socialAccounts];
    } else if (category == AtCategory.GAMER) {
      _fields = [..._gameFields];
    } else if (category == AtCategory.LOCATION) {
      _fields = [..._locationFields];
    }
    //   _fields = [...FieldNames().getFieldList(atCategory, isPreview: true)];
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
    Navigator.of(context).pop(fields);
  }
}
