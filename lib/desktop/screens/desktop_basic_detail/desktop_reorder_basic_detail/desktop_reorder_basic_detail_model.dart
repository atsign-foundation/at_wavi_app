import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopReorderBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;
  final AtCategory atCategory;

  List<String> _fields = [];

  List<String> get fields => _fields;

  static const _details = [
    'Media',
    'Basic Details',
    'Additional Details',
    'Location',
  ];
  static const _channels = [
    'Social',
    'Game',
  ];
  static const _features = [
    'Instagram',
    'Twitter',
  ];

  List<String> get detailsFields {
    return _details;
  }

  List<String> get channelsFields {
    return _channels;
  }

  List<String> get featuresFields {
    return _features;
  }

  DesktopReorderBasicDetailModel({
    required this.userPreview,
    required this.atCategory,
  }) {
    // FieldOrderService().initCategoryFields(atCategory);
    fetchFields(atCategory);
  }

  void fetchFields(AtCategory category) async {
    if (category == AtCategory.DETAILS) {
      var savedFields = await getListStringFromSharedPreferences(
        key: MixedConstants.LIST_DETAIL_KEY,
      );
      if (savedFields == null || savedFields.isEmpty) {
        _fields = [..._details];
      } else {
        _fields = savedFields;
      }
    } else if (category == AtCategory.SOCIAL) {
      var savedFields = await getListStringFromSharedPreferences(
        key: MixedConstants.LIST_CHANNEL_KEY,
      );
      if (savedFields == null || savedFields.isEmpty) {
        _fields = [..._channels];
      } else {
        _fields = savedFields;
      }
    } else if (category == AtCategory.FEATURED) {
      var savedFields = await getListStringFromSharedPreferences(
        key: MixedConstants.LIST_FEATURE_KEY,
      );
      if (savedFields == null || savedFields.isEmpty) {
        _fields = [..._features];
      } else {
        _fields = savedFields;
      }
    }

    //  _fields = [...FieldNames().getFieldList(atCategory, isPreview: true)];
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
