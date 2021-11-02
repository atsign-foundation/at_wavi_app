import 'dart:io';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_label_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_add_location_model.dart';


class DesktopAddLocationPage extends StatefulWidget {
  const DesktopAddLocationPage({Key? key}) : super(key: key);

  @override
  _DesktopAddLocationPageState createState() =>
      _DesktopAddLocationPageState();
}

class _DesktopAddLocationPageState extends State<DesktopAddLocationPage> {
  late DesktopAddLocationModel _model;
  final _showHideController = ShowHideController(isShow: true);
  final _titleTextController = TextEditingController();
  final _textContentTextController = TextEditingController();
  final _linkContentTextController = TextEditingController();
  final _numberContentTextController = TextEditingController();
  final _imageContentTextController = TextEditingController();
  final _youtubeContentTextController = TextEditingController();

  var contentDropDown = CustomContentType.values;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopAddLocationModel(userPreview: userPreview);
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
              'Add Custom Content',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 16),
            DesktopTextField(
              title: 'Title',
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
              title: 'Done',
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
    return Consumer<DesktopAddLocationModel>(builder: (_, model, child) {
      return DropdownButtonFormField<CustomContentType>(
        dropdownColor: appTheme.backgroundColor,
        autovalidateMode: AutovalidateMode.disabled,
        hint: Text('Select a type'),
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
            return 'Please select content type';
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
    return Consumer<DesktopAddLocationModel>(
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
                  label: 'Add Image',
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
      File file = File(result!.files.single.path);
      final imageData = file.readAsBytesSync();
      _model.didSelectImage(imageData);
    } else {
      // User canceled the picker
    }
  }

  void _onSaveData() {
    _model.saveData(context);
  }
}
