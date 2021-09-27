import 'dart:io';
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

  Uint8List? _selectedMedia;

  Uint8List? get selectedMedia => _selectedMedia;

  String? _selectedMediaPath;

  String? get selectedMediaPath => _selectedMediaPath;

  String? _selectedMediaExtension;

  String? get selectedMediaExtension => _selectedMediaExtension;

  bool isOnlyAddMedia = false;

  DesktopAddBasicDetailModel({required this.userPreview});

  void setIsOnlyAddMedia(bool isOnlyAddMedia) {
    this.isOnlyAddMedia = isOnlyAddMedia;
    _fieldType =
        this.isOnlyAddMedia ? CustomContentType.Image : CustomContentType.Text;
  }

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }

  void didSelectMedia(File selectedMedia, String type) {
    final mediaData = selectedMedia.readAsBytesSync();
    _selectedMedia = mediaData;
    _selectedMediaPath = selectedMedia.path;
    _selectedMediaExtension = type;
    notifyListeners();
  }

  void saveData(BuildContext context, BasicData basicData) {
    if (_fieldType == CustomContentType.Image && _selectedMedia == null) {
      CommonFunctions().showSnackBar(Strings.desktop_please_add_image);
      return;
    }
    Navigator.of(context).pop(basicData);
  }
}
