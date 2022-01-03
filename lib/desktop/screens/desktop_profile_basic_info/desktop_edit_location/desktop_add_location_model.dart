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

  Uint8List? _selectedImage;

  Uint8List? get selectedImage => _selectedImage;

  DesktopAddLocationModel({required this.userPreview});

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }

  void didSelectImage(Uint8List selectedImage) {
    _selectedImage = selectedImage;
    notifyListeners();
  }

  void saveData(BuildContext context) {
    if (_fieldType == CustomContentType.Image && _selectedImage == null) {
      CommonFunctions().showSnackBar('Please add image');
      return;
    }
    //Todo
    Navigator.of(context).pop('saved');
  }
}
