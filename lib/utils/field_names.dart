import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:provider/provider.dart';

class FieldNames {
  FieldNames._();
  static FieldNames _instance = FieldNames._();
  factory FieldNames() => _instance;

  static const _detailsTabs = ['Media', 'Basic Details', 'Additional Details', 'Location'];
  static const _channelsTabs = ['Social', 'Game'];
  static const _featuredTabs = ['Twitter', 'Instagram'];

  static const _basicDetails = ['firstname', 'lastname', 'phone', 'email'];
  static const _additionalDetails = ['pronoun', 'about'];
  static const _socialAccounts = [
    'twitter',
    'facebook',
    'linkedin',
    'instagram',
    'youtube',
    'tumblr',
    'medium'
  ];
  static const _gameFields = ['ps4', 'xbox', 'steam', 'discord'];
  static const _locationFields = [
    'locationnickname',
    'location',
  ];

  static const _basicDetailsEnum = [
    FieldsEnum.PHONE,
    FieldsEnum.EMAIL,
    FieldsEnum.FIRSTNAME,
    FieldsEnum.LASTNAME
  ];
  static const _additionalDetailsEnum = [FieldsEnum.PRONOUN, FieldsEnum.ABOUT];
  static const _socialAccountsEnum = [
    FieldsEnum.TWITTER,
    FieldsEnum.FACEBOOK,
    FieldsEnum.LINKEDIN,
    FieldsEnum.INSTAGRAM,
    FieldsEnum.YOUTUBE,
    FieldsEnum.TUMBLR,
    FieldsEnum.MEDIUM
  ];
  static const _gameFieldsEnum = [
    FieldsEnum.PS4,
    FieldsEnum.XBOX,
    FieldsEnum.STEAM,
    FieldsEnum.DISCORD
  ];

  List<String> get detailsTabs {
    return _detailsTabs;
  }

  List<String> get channelsTabs {
    return _channelsTabs;
  }

  List<String> get featuredTabs {
    return _featuredTabs;
  }

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

  List<String> get locationFields {
    return _locationFields;
  }

  List<FieldsEnum> get basicDetailsFieldsEnum {
    return _basicDetailsEnum;
  }

  List<FieldsEnum> get additionalDetailsFieldsEnum {
    return _additionalDetailsEnum;
  }

  List<FieldsEnum> get socialAccountsFieldsEnum {
    return _socialAccountsEnum;
  }

  List<FieldsEnum> get gameFieldsEnum {
    return _gameFieldsEnum;
  }

  List<String> getFieldList(AtCategory category, {bool isPreview = false}) {
    var fields = <String>[];

    if (category == AtCategory.DETAILS) {
      fields = [..._basicDetails];
    } else if (category == AtCategory.ADDITIONAL_DETAILS) {
      fields = [..._additionalDetails];
    } else if (category == AtCategory.SOCIAL) {
      fields = [..._socialAccounts];
    } else if (category == AtCategory.GAMER) {
      fields = [..._gameFields];
    } else if (category == AtCategory.LOCATION) {
      fields = [..._locationFields];
    } else if (category == AtCategory.DETAILS_TAB) {
      fields = [..._detailsTabs];
    } else if (category == AtCategory.CHANNELS) {
      fields = [..._channelsTabs];
    } else if (category == AtCategory.FEATURED) {
      fields = [..._featuredTabs];
    }

    var sortedFields = [...fields];

    List<BasicData>? customFields;
    if (isPreview) {
      customFields = [
        ...Provider.of<UserPreview>(NavService.navKey.currentContext!,
                    listen: false)
                .user()!
                .customFields[category.name] ??
            []
      ];
    } else {
      if (Provider.of<UserProvider>(NavService.navKey.currentContext!,
                  listen: false)
              .user!
              .customFields[category.name] !=
          null) {
        customFields = [
          ...Provider.of<UserProvider>(NavService.navKey.currentContext!,
                      listen: false)
                  .user!
                  .customFields[category.name] ??
              []
        ];
      }
    }

    if (customFields != null) {
      for (var field in customFields) {
        if (field.accountName != null && field.accountName != '') {
          sortedFields.add(field.accountName!);
        }
      }
    }
    return sortFieldList([...sortedFields], category, isPreview: isPreview);
  }

  List<FieldsEnum> getFieldListEnum(AtCategory category,
      {bool isPreview = false}) {
    var sortedList = <FieldsEnum>[];
    if (category == AtCategory.DETAILS) {
      sortedList = [..._basicDetailsEnum];
    } else if (category == AtCategory.ADDITIONAL_DETAILS) {
      sortedList = [..._additionalDetailsEnum];
    } else if (category == AtCategory.SOCIAL) {
      sortedList = [..._socialAccountsEnum];
    } else if (category == AtCategory.GAMER) {
      sortedList = [..._gameFieldsEnum];
    }
    return sortedList;
  }

  List<FieldsEnum> sortFieldEnum(
      List<FieldsEnum> fieldList, AtCategory category,
      {bool isPreview = false}) {
    var fieldOrder = [
      ...FieldOrderService().getFieldList(category, isPreview: isPreview)
    ];

    // if no reorder has been done
    if (fieldOrder.isEmpty) {
      return fieldList;
    }

    for (int i = 0; i < fieldOrder.length; i++) {
      var index = fieldList.indexWhere((el) => el.name == fieldOrder[i]);
      if (index != -1) {
        // swapping fieldsin new position
        var indexElement = fieldList[index];
        fieldList[index] = fieldList[i];
        fieldList[i] = indexElement;
      }
    }
    return fieldList;
  }

  List<String> sortFieldList(List<String> fieldList, AtCategory category,
      {bool isPreview = false}) {
    var fieldOrder = [
      ...FieldOrderService().getFieldList(category, isPreview: isPreview)
    ];

    if (fieldOrder.isEmpty) {
      return fieldList;
    }

    // if new fields are added from older version of app and these are not present in field order
    // we will append these fields at the end of reorder list.
    for (int i = 0; i < fieldList.length; i++) {
      if (fieldList[i].contains(AtText.IS_DELETED)) {
        continue;
      }
      int index = fieldOrder.indexWhere((element) => element == fieldList[i]);
      if (index == -1) {
        fieldOrder.add(fieldList[i]);
      }
    }

    // saving the new reorder list.
    if (isPreview) {
      FieldOrderService().updateField(category, fieldOrder);
    }
    return fieldOrder;
  }
}
