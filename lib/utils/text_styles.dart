import 'package:at_common_flutter/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/services/size_config.dart';

class CustomTextStyles {
  static TextStyle white({int size = 16}) => TextStyle(
      color: ColorConstants.white,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle whiteBold({int size = 16}) => TextStyle(
      color: ColorConstants.white,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static TextStyle black({int size = 16}) => TextStyle(
      color: ColorConstants.black,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle blackBold({int size = 16}) => TextStyle(
      color: ColorConstants.black,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static TextStyle customTextStyle(Color color, {int size = 16}) => TextStyle(
      color: color,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle customBoldTextStyle(Color color, {int size = 16}) =>
      TextStyle(
          color: color,
          fontSize: size.toFont,
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold);
}

class TextStyles {
  static TextStyle black18bold = TextStyle(
      fontSize: 18.toFont, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle grey15 =
      TextStyle(fontSize: 15.toFont, color: ColorConstants.greyText);

  static TextStyle grey16 =
      TextStyle(fontSize: 16.toFont, color: ColorConstants.greyText);

  static TextStyle grey14 =
      TextStyle(fontSize: 14.toFont, color: ColorConstants.greyText);

  static TextStyle orange18bold = TextStyle(
      fontSize: 18.toFont,
      color: ColorConstants.orange,
      fontWeight: FontWeight.w500);

  static TextStyle purple18bold = TextStyle(
      fontSize: 18.toFont,
      color: ColorConstants.purple,
      fontWeight: FontWeight.bold);

  static TextStyle boldText(Color color, {int size = 16}) => TextStyle(
      color: color,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static TextStyle lightText(Color color, {int size = 16}) => TextStyle(
        color: color,
        fontSize: size.toFont,
        letterSpacing: 0.1,
      );

  static TextStyle lightPurpleText14 =
      TextStyle(fontSize: 14.toFont, color: ColorConstants.lightPurpleText);

  static TextStyle purple16 =
      TextStyle(fontSize: 16.toFont, color: ColorConstants.purple);

  static TextStyle orange16 =
      TextStyle(fontSize: 16.toFont, color: ColorConstants.orange);

  static TextStyle linkText({int size = 16}) => TextStyle(
      color: Colors.blue,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      decoration: TextDecoration.underline);
}
