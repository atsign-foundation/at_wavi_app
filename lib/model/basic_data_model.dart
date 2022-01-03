import 'package:at_wavi_app/desktop/widgets/buttons/desktop_private_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/material.dart';

class BasicDataModel {
  BasicData data;
  bool isCustomField;
  TextEditingController? controller;
  late DesktopPublicController publicController;

  BasicDataModel({
    required this.data,
    required this.isCustomField,
  }) {
    if (data.value is String) {
      controller = TextEditingController(text: data.value);
    }
    publicController = DesktopPublicController(isPublic: !data.isPrivate);
  }
}
