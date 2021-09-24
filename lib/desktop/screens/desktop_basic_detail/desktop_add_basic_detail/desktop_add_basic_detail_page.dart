import 'dart:io';

import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_reorder_basic_detail/widgets/desktop_reorderable_item_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_label_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/image_picker.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_add_basic_detail_model.dart';

class DesktopAddBasicDetailPage extends StatefulWidget {
  bool isOnlyAddImage;

  DesktopAddBasicDetailPage({
    Key? key,
    this.isOnlyAddImage = false,
  }) : super(key: key);

  @override
  _DesktopAddBasicDetailPageState createState() =>
      _DesktopAddBasicDetailPageState();
}

class _DesktopAddBasicDetailPageState extends State<DesktopAddBasicDetailPage> {
  late DesktopAddBasicDetailModel _model;
  final _showHideController = ShowHideController(isShow: true);
  final _titleTextController = TextEditingController();
  final _textContentTextController = TextEditingController();
  final _linkContentTextController = TextEditingController();
  final _numberContentTextController = TextEditingController();
  final _imageContentTextController = TextEditingController();
  final _youtubeContentTextController = TextEditingController();

  late var contentDropDown;

  @override
  void initState() {
    contentDropDown = widget.isOnlyAddImage
        ? [CustomContentType.Image]
        : CustomContentType.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopAddBasicDetailModel(userPreview: userPreview);
        _model.setIsOnlyAddImage(widget.isOnlyAddImage);
        return _model;
      },
      child: Container(
        width: 434,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isOnlyAddImage
                  ? Strings.desktop_add_media
                  : Strings.desktop_add_custom_content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 16),
            DesktopTextField(
              title: Strings.desktop_title,
              controller: _titleTextController,
            ),
            _buildTypeSelectionWidget(),
            _buildFieldInputWidget(),
            Container(height: 1, color: appTheme.separatorColor),
            SizedBox(height: 16),
            DesktopShowHideRadioButton(
              controller: _showHideController,
            ),
            SizedBox(height: 16),
            DesktopButton(
              title: Strings.desktop_done,
              width: double.infinity,
              onPressed: _onSaveData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelectionWidget() {
    final appTheme = AppTheme.of(context);
    return Consumer<DesktopAddBasicDetailModel>(builder: (_, model, child) {
      return DropdownButtonFormField<CustomContentType>(
        dropdownColor: appTheme.backgroundColor,
        autovalidateMode: AutovalidateMode.disabled,
        hint: Text(Strings.desktop_select_type),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appTheme.separatorColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appTheme.primaryColor),
          ),
        ),
        value: model.fieldType,
        icon: Icon(Icons.keyboard_arrow_down),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: appTheme.primaryTextColor,
        ),
        validator: (value) {
          if (value == null) {
            return Strings.desktop_please_select_type;
          }
          return null;
        },
        onChanged: (newValue) {
          if (newValue != null) {
            _model.changeField(newValue);
          }
        },
        items: contentDropDown.map<DropdownMenuItem<CustomContentType>>(
            (CustomContentType value) {
          return DropdownMenuItem<CustomContentType>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
      );
    });
  }

  Widget _buildFieldInputWidget() {
    final appTheme = AppTheme.of(context);
    return Consumer<DesktopAddBasicDetailModel>(
      builder: (_, model, child) {
        if (_model.fieldType == CustomContentType.Text) {
          return DesktopTextField(
            controller: _textContentTextController,
            hint: '',
          );
        } else if (_model.fieldType == CustomContentType.Link) {
          return DesktopTextField(
            controller: _linkContentTextController,
            hint: 'https:www//example.com',
          );
        } else if (_model.fieldType == CustomContentType.Number) {
          return DesktopTextField(
            controller: _numberContentTextController,
            hint: '',
          );
        } else if (_model.fieldType == CustomContentType.Image) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesktopIconLabelButton(
                  iconData: Icons.add,
                  label: Strings.desktop_add_image,
                  onPressed: _onSelectImage,
                ),
                if (model.selectedImage != null)
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 200.0,
                    ),
                    child: Image.memory(model.selectedImage!),
                  ),
              ],
            ),
          );
        } else if (_model.fieldType == CustomContentType.Youtube) {
          return DesktopTextField(
            controller: _youtubeContentTextController,
            hint: 'https://www.youtube.com',
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _onSelectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result?.files.single.path != null) {
      File file = File(result!.files.single.path!);
      _model.didSelectImage(file);
    } else {
      // User canceled the picker
    }
  }

  void _onSaveData() {
    var basicData = BasicData(
      value: _titleTextController.text,
      accountName: _titleTextController.text,
      type: _model.fieldType,
    );
    if (_model.fieldType == CustomContentType.Text) {
      basicData.valueDescription = _textContentTextController.text;
    } else if (_model.fieldType == CustomContentType.Link) {
      basicData.valueDescription = _linkContentTextController.text;
    } else if (_model.fieldType == CustomContentType.Number) {
      basicData.valueDescription = _numberContentTextController.text;
    } else if (_model.fieldType == CustomContentType.Youtube) {
      basicData.valueDescription = _youtubeContentTextController.text;
    } else if (_model.fieldType == CustomContentType.Image) {
      basicData.path = _model.selectedImagePath;
    }
    _model.saveData(context, basicData);
  }
}
