import 'dart:convert';

import 'package:at_wavi_app/common_components/add_custom_content_button.dart';
import 'package:at_wavi_app/common_components/custom_input_field.dart';
import 'package:at_wavi_app/common_components/public_private_bottomsheet.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  BasicData? _data;
  late bool _isPrivate;
  String _locationString = '', _locationNickname = '';

  @override
  initState() {
    _isPrivate = false;
    _data = Provider.of<UserProvider>(context, listen: false).user!.location;
    _locationNickname = Provider.of<UserProvider>(context, listen: false)
            .user!
            .locationNickName
            .value ??
        'Home';
    _isPrivate = Provider.of<UserProvider>(context, listen: false)
        .user!
        .location
        .isPrivate;
    super.initState();
  }

  updateIsPrivate(bool _mode) {
    setState(() {
      _isPrivate = _mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    _locationString = (_data != null && (_data!.value != null))
        ? jsonDecode(_data!.value)['location']
        : '';

    return Scaffold(
      bottomSheet: InkWell(
        onTap: (_locationString == '')
            ? () {
                _showToast('Enter Location', isError: true);
              }
            : _updateLocation,
        child: Container(
            alignment: Alignment.center,
            height: 70.toHeight,
            width: SizeConfig().screenWidth,
            color: _locationString == ''
                ? ColorConstants.dullColor(
                    color: ColorConstants.black, opacity: 0.5)
                : ColorConstants.black,
            child: Text(
              'Done',
              style: CustomTextStyles.customTextStyle(ColorConstants.white,
                  size: 18),
            )),
      ),
      appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'Location',
            style: CustomTextStyles.customBoldTextStyle(
                Theme.of(context).primaryColor,
                size: 16),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                showPublicPrivateBottomSheet(
                    onPublicClicked: () {
                      updateIsPrivate(false);
                    },
                    onPrivateClicked: () {
                      updateIsPrivate(true);
                    },
                    height: 200.toHeight);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: _isPrivate ? Icon(Icons.lock) : Icon(Icons.public)),
            )
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.toHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Text('Tag',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.toWidth, vertical: 0.toHeight),
            child: CustomInputField(
              borderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              width: double.infinity,
              hintText: 'Enter the tag',
              hintTextColor: ColorConstants.black.withOpacity(0.5),
              bgColor: Colors.transparent,
              textColor: ColorConstants.black,
              initialValue: _locationNickname,
              baseOffset: _locationNickname.length,
              height: 70,
              expands: false,
              maxLines: 1,
              value: (str) => setState(() {
                _locationNickname = str;
              }),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Text('Location',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.toWidth, vertical: 12.toHeight),
            child: CustomInputField(
              borderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              width: double.infinity,
              hintText: 'Search',
              hintTextColor: ColorConstants.black.withOpacity(0.5),
              bgColor: Colors.transparent,
              textColor: ColorConstants.black,
              initialValue: _locationString,
              baseOffset: _locationString.length,
              height: 70,
              expands: false,
              maxLines: 1,
              value: (str) => setState(() {
                _data!.value = str;
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: AddCustomContentButton(
              text: 'Add more location',
            ),
          )
        ],
      ),
    );
  }

  _updateLocation() async {}

  _showToast(String _text, {bool isError = false, Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
          isError ? ColorConstants.RED : bgColor ?? ColorConstants.black,
      content: Text(
        _text,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 1),
    ));
  }
}
