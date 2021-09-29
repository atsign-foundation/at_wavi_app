import 'dart:io';
import 'dart:typed_data';

import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopAddBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;

  CustomContentType _fieldType = CustomContentType.Text;

  CustomContentType get fieldType => _fieldType;

  BasicData? _basicData;

  BasicData? get basicData => _basicData;

  Uint8List? _uInt8list;

  Uint8List? get uInt8list => _uInt8list;

  bool isOnlyAddMedia = false;

  var titleTextController = TextEditingController(text: '');
  var valueContentTextController = TextEditingController(text: '');

  DesktopAddBasicDetailModel({required this.userPreview}) {
    _basicData = BasicData();
  }

  void setIsOnlyAddMedia(bool isOnlyAddMedia) {
    this.isOnlyAddMedia = isOnlyAddMedia;
    _fieldType =
        this.isOnlyAddMedia ? CustomContentType.Image : CustomContentType.Text;
  }

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }

  Future didSelectMedia(File selectedMedia, String extension) async {
    final mediaData = await selectedMedia.readAsBytes();
    _basicData!.value = selectedMedia.path;
    _basicData!.extension = extension;
    _uInt8list = mediaData;
    notifyListeners();
  }

  Future saveData(BuildContext context) async {
    if (_fieldType == CustomContentType.Image && _basicData!.value == null) {
      CommonFunctions().showSnackBar(Strings.desktop_please_add_image);
      return;
    }
    _basicData!.accountName = titleTextController.text;
    if (_fieldType != CustomContentType.Image) {
      _basicData!.value = valueContentTextController.text;
    }
    _basicData!.type = fieldType;
    await updateDefinedFields(
      context,
      _basicData!,
      isCustomData: true,
    );

    Navigator.of(context).pop('saved');
  }
}
