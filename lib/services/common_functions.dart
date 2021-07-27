import 'dart:typed_data';

import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';
import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  CommonFunctions._internal();
  static CommonFunctions _instance = CommonFunctions._internal();
  factory CommonFunctions() => _instance;

  List<Widget> getCustomCardForFields(
      ThemeData _themeData, List<String> fields) {
    var userMap = User.toJson(UserProvider().user!);

    List<Widget> fieldsWidgets = [];
    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        var widget = Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: field.key,
                  subtitle: field.value.value,
                  themeData: _themeData,
                )),
            Divider(
              height: 1,
            )
          ],
        );

        fieldsWidgets.add(widget);
      }
    }
    return fieldsWidgets;
  }

  getCachedContactImage(String atsign) {
    Uint8List image;
    AtContact contact = checkForCachedContactDetail(atsign);

    if (contact != null &&
        contact.tags != null &&
        contact.tags!['image'] != null) {
      List<int> intList = contact.tags!['image'].cast<int>();
      image = Uint8List.fromList(intList);
      return image;
    }
  }
}
