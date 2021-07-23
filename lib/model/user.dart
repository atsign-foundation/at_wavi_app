import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  bool allPrivate;
  String atsign;
  BasicData image;
  BasicData firstname;
  BasicData lastname;
  BasicData phone;
  BasicData email;
  BasicData about;
  BasicData location;
  BasicData locationNickName;
  BasicData pronoun;
  BasicData twitter;
  BasicData facebook;
  BasicData linkedin;
  BasicData instagram;
  BasicData youtube;
  BasicData tumbler;
  BasicData medium;
  BasicData ps4;
  BasicData xbox;
  BasicData steam;
  BasicData discord;
  Map<String, List<BasicData>> customFields;

  User(
      {allPrivate,
      atsign,
      image,
      firstname,
      lastname,
      location,
      locationNickName,
      pronoun,
      phone,
      email,
      about,
      twitter,
      facebook,
      linkedin,
      instagram,
      youtube,
      tumbler,
      medium,
      ps4,
      xbox,
      steam,
      discord,
      customFields})
      : this.allPrivate = allPrivate,
        this.atsign = atsign,
        this.image = image ?? BasicData(),
        this.firstname = firstname ?? BasicData(),
        this.lastname = lastname ?? BasicData(),
        this.location = location ?? BasicData(),
        this.locationNickName = locationNickName ?? BasicData(),
        this.pronoun = pronoun ?? BasicData(),
        this.phone = phone ?? BasicData(),
        this.email = email ?? BasicData(),
        this.about = about ?? BasicData(),
        this.twitter = twitter ?? BasicData(),
        this.facebook = facebook ?? BasicData(),
        this.linkedin = linkedin ?? BasicData(),
        this.instagram = instagram ?? BasicData(),
        this.youtube = youtube ?? BasicData(),
        this.tumbler = tumbler ?? BasicData(),
        this.medium = medium ?? BasicData(),
        this.ps4 = ps4 ?? BasicData(),
        this.xbox = xbox ?? BasicData(),
        this.steam = steam ?? BasicData(),
        this.discord = discord ?? BasicData(),
        this.customFields = customFields ?? {};
}

/// [accountName] is the label of the data
/// [valueDescription] is any description of the data
class BasicData {
  var value;
  bool isPrivate = false;
  Icon? icon;
  String? accountName, valueDescription;
  var type;
  BasicData(
      {this.value,
      this.isPrivate = false,
      this.icon,
      this.accountName,
      this.type,
      this.valueDescription});

  @override
  String toString() {
    return 'value: $value, isPrivate: $isPrivate, icon: $icon, accountName:$accountName, type:$type, valueDescription:$valueDescription';
  }
}

BasicData formData(name, value, {private, type, valueDescription}) {
  BasicData basicdata = BasicData(
      accountName: name,
      // icon: setIcon(name),
      isPrivate: private ?? false,
      type: TextInputType.text,
      value: value,
      valueDescription: valueDescription);
  return basicdata;
}

// setIcon(fieldName) {
//   FieldsEnum field = valueOf(fieldName);

//   switch (field) {
//     case FieldsEnum.TWITTER:
//       return Icon(FontAwesomeIcons.twitter, color: Colors.blue, size: 30);
//       break;
//     case FieldsEnum.FACEBOOK:
//       return Icon(FontAwesomeIcons.facebook,
//           color: Colors.indigo[700], size: 30);
//       break;
//     case FieldsEnum.LINKEDIN:
//       return Icon(FontAwesomeIcons.linkedin,
//           color: Colors.indigo[700], size: 30);
//       break;
//     case FieldsEnum.INSTAGRAM:
//       return Icon(FontAwesomeIcons.instagram, color: Colors.red, size: 30);
//       break;
//     case FieldsEnum.YOUTUBE:
//       return Icon(FontAwesomeIcons.youtube, color: Colors.red[700], size: 30);
//       break;
//     case FieldsEnum.TUMBLR:
//       return Icon(FontAwesomeIcons.tumblr, color: Colors.indigo[800], size: 30);
//       break;
//     case FieldsEnum.MEDIUM:
//       return Icon(FontAwesomeIcons.medium, color: Colors.black, size: 30);
//       break;
//     case FieldsEnum.XBOX:
//       return Icon(MdiIcons.microsoftXbox, color: Colors.green[800], size: 30);
//       break;
//     case FieldsEnum.DISCORD:
//       return Icon(MdiIcons.discord, color: Colors.indigo, size: 30);
//       break;
//     case FieldsEnum.STEAM:
//       return Icon(MdiIcons.steam, color: Colors.blue, size: 30);
//       break;
//     case FieldsEnum.PS4:
//       return Icon(MdiIcons.sonyPlaystation, color: Colors.indigo, size: 30);
//     default:
//       return null;
//       break;
//   }
// }
