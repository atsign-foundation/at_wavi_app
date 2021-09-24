import 'dart:typed_data';

import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopAddBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  CustomContentType _fieldType = CustomContentType.Text;

  CustomContentType get fieldType => _fieldType;

  Uint8List? _selectedImage;

  Uint8List? get selectedImage => _selectedImage;

  bool isOnlyAddImage = false;

  DesktopAddBasicDetailModel({required this.userPreview});

  void setIsOnlyAddImage(bool isOnlyAddImage) {
    this.isOnlyAddImage = isOnlyAddImage;
    _fieldType =
        this.isOnlyAddImage ? CustomContentType.Image : CustomContentType.Text;
  }

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }

  void didSelectImage(Uint8List selectedImage) {
    _selectedImage = selectedImage;
    notifyListeners();
  }

  void saveData(BuildContext context, BasicData basicData) {
    if (_fieldType == CustomContentType.Image && _selectedImage == null) {
      CommonFunctions().showSnackBar(Strings.desktop_please_add_image);
      return;
    }
    Navigator.of(context).pop(basicData);
  }
}
