import 'dart:typed_data';

import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          message,
          style: TextStyle(
            color: ColorConstants.white,
            fontSize: 14,
          ),
        ),
      ),
      backgroundColor: color,
      duration: Duration(
        seconds: 2,
      ),
    ),
  );
}

Future<Uint8List?> getVideoThumbnail(String path) async {
  final uInt8list = await VideoCompress.getByteThumbnail(
    path,
    quality: 50,
  );
  return uInt8list;
}

String getTitle(String title) {
  switch (title) {
    case 'firstname':
      return 'First Name';
    case 'lastname':
      return 'Last Name';
    case 'phone':
      return 'Phone';
    case 'email':
      return 'Email';
    case 'pronoun':
      return 'Preferred Pronoun';
    case 'about':
      return 'About';
    case 'twitter':
      return 'Twitter';
    case 'facebook':
      return 'Facebook';
    case 'linkedin':
      return 'Linkedin';
    case 'instagram':
      return 'Instagram';
    case 'youtube':
      return 'Youtube';
    case 'tumblr':
      return 'Tumblr';
    case 'medium':
      return 'Medium';
    case 'ps4':
      return 'PS4';
    case 'xbox':
      return 'XBox';
    case 'steam':
      return 'Steam';
    case 'discord':
      return 'Discord';
    default:
      return title;
  }
}

String getCategory(String screen) {
  switch (screen) {
    case MixedConstants.BASIC_DETAILS_KEY:
      return AtCategory.DETAILS.name;
    case MixedConstants.ADDITIONAL_DETAILS_KEY:
      return AtCategory.ADDITIONAL_DETAILS.name;
    case MixedConstants.MEDIA_KEY:
      return AtCategory.IMAGE.name;
    case MixedConstants.LOCATION_KEY:
      return AtCategory.LOCATION.name;
    case MixedConstants.GAME_KEY:
      return AtCategory.GAMER.name;
    case MixedConstants.SOCIAL_KEY:
      return AtCategory.SOCIAL.name;
    default:
      return '';
  }
}

Future updateCustomFields(
  BuildContext context,
  List<BasicData> listBasicData, {
  bool isCustomData = false,
}) async {
  var currentScreen = await getStringFromSharedPreferences(
    key: Strings.desktop_current_screen,
  );
  var category = getCategory(currentScreen!);
  Provider.of<UserPreview>(context, listen: false)
      .user()!
      .customFields[category] = listBasicData;
}

/// [updateDefinedFields]can be used to either update or delete value
/// when deleting send [BasicData] with just accountname
/// when updating send complete [BasicData].
Future updateDefinedFields(
  BuildContext context,
  BasicData basicData, {
  bool isCustomData = false,
}) async {
  if (isCustomData) {
    var currentScreen = await getStringFromSharedPreferences(
      key: Strings.desktop_current_screen,
    );
    var category = getCategory(currentScreen!);
    var customFields = Provider.of<UserPreview>(context, listen: false)
            .user()!
            .customFields[category] ??
        [];
    customFields.add(basicData);

    Provider.of<UserPreview>(context, listen: false)
        .user()!
        .customFields[category] = customFields;
  } else {
    if (basicData.accountName == FieldsEnum.IMAGE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.image =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LASTNAME.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.lastname =
          basicData;
    } else if (basicData.accountName == FieldsEnum.FIRSTNAME.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.firstname =
          basicData;
    } else if (basicData.accountName == FieldsEnum.PHONE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.phone =
          basicData;
    } else if (basicData.accountName == FieldsEnum.EMAIL.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.email =
          basicData;
    } else if (basicData.accountName == FieldsEnum.ABOUT.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.about =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LOCATION.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.location =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LOCATIONNICKNAME.name) {
      Provider.of<UserPreview>(context, listen: false)
          .user()!
          .locationNickName = basicData;
    } else if (basicData.accountName == FieldsEnum.PRONOUN.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.pronoun =
          basicData;
    } else if (basicData.accountName == FieldsEnum.TWITTER.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.twitter =
          basicData;
    } else if (basicData.accountName == FieldsEnum.FACEBOOK.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.facebook =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LINKEDIN.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.linkedin =
          basicData;
    } else if (basicData.accountName == FieldsEnum.INSTAGRAM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.instagram =
          basicData;
    } else if (basicData.accountName == FieldsEnum.YOUTUBE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.youtube =
          basicData;
    } else if (basicData.accountName == FieldsEnum.TUMBLR.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.tumbler =
          basicData;
    } else if (basicData.accountName == FieldsEnum.MEDIUM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.medium =
          basicData;
    } else if (basicData.accountName == FieldsEnum.PS4.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.ps4 = basicData;
    } else if (basicData.accountName == FieldsEnum.XBOX.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.xbox = basicData;
    } else if (basicData.accountName == FieldsEnum.STEAM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.steam =
          basicData;
    } else if (basicData.accountName == FieldsEnum.DISCORD.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.discord =
          basicData;
    }
  }
}
