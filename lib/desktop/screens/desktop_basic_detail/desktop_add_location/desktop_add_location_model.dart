import 'dart:typed_data';

import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopAddLocationModel extends ChangeNotifier {
  final UserPreview userPreview;

  CustomContentType _fieldType = CustomContentType.Text;

  CustomContentType get fieldType => _fieldType;

  BasicData? _data;
  BasicData? get data => _data;
  late bool _isPrivate;
  String _locationString = '', _locationNickname = '';

  DesktopAddLocationModel({required this.userPreview}) {
    _data = userPreview.user()!.location;
    _locationNickname = userPreview.user()!.locationNickName.value ?? '';
    _isPrivate = userPreview.user()!.location.isPrivate;
  }

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }


  void saveData(BuildContext context) {
    //Todo
    Navigator.of(context).pop('saved');
  }
}
