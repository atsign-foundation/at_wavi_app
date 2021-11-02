import 'dart:io';
import 'dart:typed_data';

import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopAddBasicDetailModel extends ChangeNotifier {
  final UserPreview userPreview;
  final AtCategory atCategory;

  CustomContentType _fieldType = CustomContentType.Text;

  CustomContentType get fieldType => _fieldType;

  BasicData? _basicData;

  BasicData? get basicData => _basicData;

  Uint8List? _uInt8list;

  Uint8List? get uInt8list => _uInt8list;

  bool isOnlyAddMedia = false;

  final titleTextController = TextEditingController(text: '');
  final valueContentTextController = TextEditingController(text: '');
  final showHideController = ShowHideController(isShow: true);

  final BasicData? originBasicData;

  DesktopAddBasicDetailModel({
    required this.userPreview,
    required this.atCategory,
    this.originBasicData,
  }) {
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

  Future addCustomField(BuildContext context) async {
    if (_fieldType == CustomContentType.Image && _basicData!.value == null) {
      CommonFunctions().showSnackBar(Strings.desktop_please_add_image);
      return;
    }
    _basicData!.accountName = titleTextController.text;
    _basicData!.isPrivate = showHideController.isShow == false;
    if (_fieldType != CustomContentType.Image) {
      _basicData!.value = valueContentTextController.text;
    }
    _basicData!.type = fieldType.name;
    // await updateDefinedFields(
    //   context,
    //   _basicData!,
    //   isCustomData: true,
    // );

    List<BasicData>? customFields =
        userPreview.user()!.customFields[atCategory.name];
    customFields!.add(_basicData!);

    userPreview.user()?.customFields[atCategory.name] = customFields;

    FieldOrderService().addNewField(atCategory, _basicData!.accountName!);

    Navigator.of(context).pop('saved');
  }

  Future updateCustomField(BuildContext context) async {
    if (_fieldType == CustomContentType.Image && _basicData!.value == null) {
      CommonFunctions().showSnackBar(Strings.desktop_please_add_image);
      return;
    }
    _basicData!.accountName = titleTextController.text;
    _basicData!.isPrivate = showHideController.isShow == false;
    if (_fieldType != CustomContentType.Image) {
      _basicData!.value = valueContentTextController.text;
    }
    _basicData!.type = fieldType.name;

    List<BasicData>? customFields =
        userPreview.user()!.customFields[atCategory.name];

    int index = customFields?.indexWhere(
            (element) => element.accountName == originBasicData?.accountName) ??
        -1;
    if (index >= 0) {
      customFields![index] = _basicData!;
    }

    userPreview.user()?.customFields[atCategory.name] = customFields!;

    Navigator.of(context).pop('saved');
  }
}
