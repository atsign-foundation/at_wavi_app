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

  List<String> getFieldList(AtCategory category) {
    switch (category) {
      case AtCategory.DETAILS:
        return _basicDetails;
      case AtCategory.ADDITIONAL_DETAILS:
        return _additionalDetails;
      case AtCategory.SOCIAL:
        return _socialAccounts;
      case AtCategory.GAMER:
        return _gameFields;
      default:
        return [];
    }
  }

  List<FieldsEnum> getFieldListEnum(AtCategory category) {
    switch (category) {
      case AtCategory.DETAILS:
        return _basicDetailsEnum;
      case AtCategory.ADDITIONAL_DETAILS:
        return _additionalDetailsEnum;
      case AtCategory.SOCIAL:
        return _socialAccountsEnum;
      case AtCategory.GAMER:
        return _gameFieldsEnum;
      default:
        return [];
    }
  }
}
