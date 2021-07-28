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
}
