import 'dart:typed_data';

import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/material.dart';

class BasicDataModel {
  BasicData data;
  bool isCustomField;
  TextEditingController? controller;

  BasicDataModel({
    required this.data,
    required this.isCustomField,
    this.controller,
  });
}
