import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class TextStyles {
  static TextStyle black18bold = TextStyle(
      fontSize: 18.toFont, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle grey15 =
      TextStyle(fontSize: 15.toFont, color: ColorConstants.greyText);

  static TextStyle orange18bold = TextStyle(
      fontSize: 18.toFont,
      color: ColorConstants.orange,
      fontWeight: FontWeight.w500);

  static TextStyle purple18bold = TextStyle(
      fontSize: 18.toFont,
      color: ColorConstants.purple,
      fontWeight: FontWeight.bold);

  static TextStyle lightPurpleText14 =
      TextStyle(fontSize: 14.toFont, color: ColorConstants.lightPurpleText);

  static TextStyle purple16 =
      TextStyle(fontSize: 16.toFont, color: ColorConstants.purple);
}
