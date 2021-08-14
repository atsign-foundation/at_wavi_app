import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';

class FieldNames {
  FieldNames._();
  static FieldNames _instance = FieldNames._();
  factory FieldNames() => _instance;

  var _basicDetails = ['phone', 'email'];
  var _additionalDetails = ['pronoun', 'about'];
  var _socialAccounts = [
    'twitter',
    'facebook',
    'linkedin',
    'instagram',
    'youtube',
    'tumblr',
    'medium'
  ];
  var _gameFields = ['ps4', 'xbox', 'steam', 'discord'];

  var _basicDetailsEnum = [FieldsEnum.PHONE, FieldsEnum.EMAIL];
  var _additionalDetailsEnum = [FieldsEnum.PRONOUN, FieldsEnum.ABOUT];
  var _socialAccountsEnum = [
    FieldsEnum.TWITTER,
    FieldsEnum.FACEBOOK,
    FieldsEnum.LINKEDIN,
    FieldsEnum.INSTAGRAM,
    FieldsEnum.YOUTUBE,
    FieldsEnum.TUMBLR,
    FieldsEnum.MEDIUM
  ];
  var _gameFieldsEnum = [
    FieldsEnum.PS4,
    FieldsEnum.XBOX,
    FieldsEnum.STEAM,
    FieldsEnum.DISCORD
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
    var sortedFileds = <String>[];

    if (category == AtCategory.DETAILS) {
      sortedFileds = _basicDetails;
    } else if (category == AtCategory.ADDITIONAL_DETAILS) {
      sortedFileds = _additionalDetails;
    } else if (category == AtCategory.SOCIAL) {
      sortedFileds = _socialAccounts;
    } else if (category == AtCategory.GAMER) {
      sortedFileds = _gameFields;
    }
    return sortFieldList(sortedFileds, category, isPreview: isPreview);
  }

  List<FieldsEnum> getFieldListEnum(AtCategory category,
      {bool isPreview = false}) {
    var sortedList = <FieldsEnum>[];
    if (category == AtCategory.DETAILS) {
      sortedList = _basicDetailsEnum;
    } else if (category == AtCategory.ADDITIONAL_DETAILS) {
      sortedList = _additionalDetailsEnum;
    } else if (category == AtCategory.SOCIAL) {
      sortedList = _socialAccountsEnum;
    } else if (category == AtCategory.DETAILS) {
      sortedList = _basicDetailsEnum;
    } else if (category == AtCategory.GAMER) {
      sortedList = _gameFieldsEnum;
    }

    // sorting fields
    return sortFieldEnum(sortedList, category, isPreview: isPreview);
  }

  List<FieldsEnum> sortFieldEnum(
      List<FieldsEnum> fieldList, AtCategory category,
      {bool isPreview = false}) {
    var fieldOrder =
        FieldOrderService().getFieldList(category, isPreview: isPreview);

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
    var fieldOrder =
        FieldOrderService().getFieldList(category, isPreview: isPreview);

    if (fieldOrder.isEmpty) {
      return fieldList;
    }

    for (int i = 0; i < fieldOrder.length; i++) {
      var index = fieldList.indexWhere((el) => el == fieldOrder[i]);
      if (index != -1) {
        // swapping fieldsin new position
        var indexElement = fieldList[index];
        fieldList[index] = fieldList[i];
        fieldList[i] = indexElement;
      }
    }
    return fieldList;
  }
}
