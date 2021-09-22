import 'package:flutter/material.dart';

enum FieldsEnum {
  PRIVATEACCOUNT,
  ATSIGN,
  IMAGE,
  FIRSTNAME,
  LASTNAME,
  EMAIL,
  PHONE,
  ABOUT,
  PRONOUN,
  LOCATION,
  LOCATIONNICKNAME,
  TWITTER,
  FACEBOOK,
  LINKEDIN,
  INSTAGRAM,
  YOUTUBE,
  MEDIUM,
  TUMBLR,
  PS4,
  XBOX,
  STEAM,
  DISCORD
}

extension FieldsEnumValues on FieldsEnum {
  String get label {
    switch (this) {
      case FieldsEnum.PRIVATEACCOUNT:
        return 'PRIVATEACCOUNT';
      case FieldsEnum.FIRSTNAME:
        return 'FIRSTNAME';
      case FieldsEnum.LASTNAME:
        return 'LASTNAME';
      case FieldsEnum.PHONE:
        return 'PHONE';
      case FieldsEnum.EMAIL:
        return 'EMAIL';
      case FieldsEnum.ABOUT:
        return 'ABOUT ME';
      case FieldsEnum.LOCATION:
        return 'SHOW ON MAP';
      case FieldsEnum.LOCATIONNICKNAME:
        return 'LOCATION NICKNAME';
      case FieldsEnum.TWITTER:
        return 'TWITTER';
      case FieldsEnum.INSTAGRAM:
        return 'INSTAGRAM';
      case FieldsEnum.FACEBOOK:
        return 'FACEBOOK';
      case FieldsEnum.LINKEDIN:
        return 'LINKEDIN';
      case FieldsEnum.TUMBLR:
        return 'TUMBLR';
      case FieldsEnum.MEDIUM:
        return 'MEDIUM';
      case FieldsEnum.YOUTUBE:
        return 'YOUTUBE';
      case FieldsEnum.PRONOUN:
        return 'PRONOUN';
      case FieldsEnum.PS4:
        return 'PS4';
      case FieldsEnum.XBOX:
        return 'XBOX';
      case FieldsEnum.STEAM:
        return 'STEAM (PC)';
      case FieldsEnum.DISCORD:
        return 'DISCORD';
      default:
        return '';
    }
  }

  String get name {
    return this.toString().split('.').last.toLowerCase();
  }

  String get title {
    return this == FieldsEnum.ABOUT
        ? 'about me'
        : this.toString().split('.').last.toLowerCase();
  }

  String get hintText {
    switch (this) {
      case FieldsEnum.PRIVATEACCOUNT:
        return 'Private Account';

      case FieldsEnum.FIRSTNAME:
        return 'First name';

      case FieldsEnum.LASTNAME:
        return 'Last name';

      case FieldsEnum.PHONE:
        return 'Phone';

      case FieldsEnum.EMAIL:
        return 'Email';

      case FieldsEnum.ABOUT:
        return 'Write a short bio or quote';

      case FieldsEnum.PRONOUN:
        return 'Preferred pronoun';

      case FieldsEnum.LOCATIONNICKNAME:
        return 'Home, Office, School, etc...';

      case FieldsEnum.LOCATION:
        return 'Type postal code, city, country, or street';

      case FieldsEnum.TWITTER:
      case FieldsEnum.INSTAGRAM:
      case FieldsEnum.FACEBOOK:
      case FieldsEnum.LINKEDIN:
      case FieldsEnum.TUMBLR:
      case FieldsEnum.MEDIUM:
      case FieldsEnum.YOUTUBE:
        return 'USERNAME';

      case FieldsEnum.PS4:
        return 'PS4';

      case FieldsEnum.XBOX:
        return 'XBOX';

      case FieldsEnum.STEAM:
        return 'Steam (PC)';

      case FieldsEnum.DISCORD:
        return 'Discord';

      default:
        return '';
    }
  }
}

valueOf(String property) {
  for (var field in FieldsEnum.values) {
    if (property == field.name) {
      return field;
    }
  }
  return '';
}

// enum CATEGORY { DETAILS, ADDITIONAL_DETAILS, LOCATION, SOCIAL, GAMER, FEATURED }

/// new app doesnt have IMAGE
enum AtCategory {
  IMAGE,
  DETAILS,
  LOCATION,
  SOCIAL,
  GAMER,

  /// Added for new wavi app
  ADDITIONAL_DETAILS,
  FEATURED,
  OTHERS,
}

extension AtCategoryValues on AtCategory {
  String get name {
    return this.toString().split('.').last;
  }

  String get label {
    switch (this) {
      case AtCategory.IMAGE:
        return 'Image';

      case AtCategory.DETAILS:
        return 'Details';

      case AtCategory.SOCIAL:
        return 'Social';

      case AtCategory.GAMER:
        return 'Gaming';

      /// Added for new wavi app
      case AtCategory.LOCATION:
        return 'Location';
      case AtCategory.FEATURED:
        return 'Featured';
      case AtCategory.ADDITIONAL_DETAILS:
        return 'Additional_Details';

      default:
        return '';
    }
  }
}

enum Operation { EDIT, DELETE, PRINT, SAVE }

List<String> tooltipOperations = [Operation.EDIT.name, Operation.DELETE.name];

extension OperationValues on Operation {
  String get name {
    switch (this) {
      case Operation.DELETE:
        return 'Delete';

      case Operation.EDIT:
        return 'Edit';

      case Operation.PRINT:
        return 'Print';

      case Operation.SAVE:
        return 'Save';

      default:
        return '';
    }
  }
}

enum LocationJson { RADIUS, LOCATION }

extension LocationJsonValues on LocationJson {
  String get name {
    return this.toString().split('.').last.toLowerCase();
  }
}

enum OnboardStatus {
  ATSIGN_NOT_FOUND,
  PRIVATE_KEY_NOT_FOUND,
  ACTIVATE,
  RESTORE
}

// extension on OnboardStatus {
//   bool isEqual => this.toString().split
// }

extension status on OnboardStatus {
  String get value => this.toString().split('.').last.toUpperCase();
  String get name {
    switch (this) {
      case OnboardStatus.ACTIVATE:
        return 'Activate';

      case OnboardStatus.RESTORE:
        return 'Restore';

      default:
        return '';
    }
  }
}

enum RootEnvironment { Staging, Production, Testing }

extension value on RootEnvironment {
  String get domain {
    switch (this) {
      case RootEnvironment.Staging:
        return 'root.atsign.wtf';

      case RootEnvironment.Production:
        return 'root.atsign.org';

      case RootEnvironment.Testing:
        return 'vip.ve.atsign.zone';

      default:
        return '';
    }
  }

  String get website {
    switch (this) {
      case RootEnvironment.Staging:
        return 'https://atsign.wtf';

      case RootEnvironment.Production:
        return 'https://atsign.com';

      case RootEnvironment.Testing:
        return 'https://atsign.wtf';

      default:
        return '';
    }
  }
  // String get apikey {
  //   switch(this){
  //     case RootEnvironment.Staging:
  //       return AppConstants.deviceapikey;
  //
  //     case RootEnvironment.Production:
  //       return AppConstants.prodapikey;
  //
  //     case RootEnvironment.Testing:
  //       return AppConstants.deviceapikey;
  //
  //     default:
  //       return '';
  //

  //   }
  // }

  String get previewLink {
    switch (this) {
      case RootEnvironment.Staging:
        return 'https://directory.atsign.wtf/';

      case RootEnvironment.Production:
        return 'https://wavi.ng/';

      case RootEnvironment.Staging:
        return 'https://directory.atsign.wtf/';

      default:
        return '';
    }
  }
}

enum CustomContentStatus { Exists, Success, Fails }
enum CustomContentType { Text, Link, Number, Image, Youtube }

extension values on CustomContentType {
  String get name {
    switch (this) {
      case CustomContentType.Text:
        return 'Text';

      case CustomContentType.Link:
        return 'Link';

      case CustomContentType.Number:
        return 'Number';

      case CustomContentType.Image:
        return 'Image';

      case CustomContentType.Youtube:
        return 'Youtube';

      default:
        return '';
    }
  }

  String get label {
    if (this == CustomContentType.Youtube) {
      return 'YouTube';
    } else {
      return this.name;
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case CustomContentType.Link:
        return TextInputType.url;

      case CustomContentType.Youtube:
        return TextInputType.url;

      case CustomContentType.Number:
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }
}

CustomContentType customContentNameToType(String name) {
  switch (name) {
    case 'Text':
      return CustomContentType.Text;

    case 'Link':
      return CustomContentType.Link;

    case 'Number':
      return CustomContentType.Number;

    case 'Image':
      return CustomContentType.Image;

    case 'Youtube':
      return CustomContentType.Youtube;

    default:
      return CustomContentType.Text;
  }
}

enum FollowType { notification, website }
