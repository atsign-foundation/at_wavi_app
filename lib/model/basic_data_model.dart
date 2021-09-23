import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/material.dart';

class BasicDataModel {
  final BasicData data;
  final bool isCustomField;
  final TextEditingController? controller;

  BasicDataModel({
    required this.data,
    required this.isCustomField,
    this.controller,
  });
}
