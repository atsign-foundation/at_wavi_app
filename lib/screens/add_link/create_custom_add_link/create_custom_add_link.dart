import 'package:at_wavi_app/common_components/custom_input_field.dart';
import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/common_components/text_tile.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/at_key_set_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CreateCustomAddLink extends StatefulWidget {
  final AtCategory category;
  final dynamic value;
  const CreateCustomAddLink(this.value, {required this.category, Key? key})
      : super(key: key);

  @override
  _CreateCustomAddLinkState createState() => _CreateCustomAddLinkState();
}

class _CreateCustomAddLinkState extends State<CreateCustomAddLink> {
  String _valueDescription = '', _accountName = '';
  bool _isPrivate = false;

  updateIsPrivate(bool _mode) {
    setState(() {
      _isPrivate = _mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomSheet: InkWell(
        onTap: (_accountName == '')
            ? () {
                _showToast('Enter title', isError: true);
              }
            : _updateCustomContent,
        child: Container(
            alignment: Alignment.center,
            height: 70.toHeight,
            width: SizeConfig().screenWidth,
            color: _accountName == ''
                ? ColorConstants.dullColor(
                    color: Theme.of(context).primaryColor, opacity: 0.5)
                : Theme.of(context).primaryColor,
            child: Text(
              'Add',
              style: CustomTextStyles.customTextStyle(
                  Theme.of(context).scaffoldBackgroundColor,
                  size: 18),
            )),
      ),
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'Add custom content',
          style: CustomTextStyles.customBoldTextStyle(
              Theme.of(context).primaryColor,
              size: 16),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.toHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Text('Title',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.toWidth, vertical: 12.toHeight),
            child: CustomInputField(
              width: double.infinity,
              hintText: 'Enter the title',
              hintTextColor: ColorConstants.black.withOpacity(0.5),
              bgColor: Colors.transparent,
              textColor: ColorConstants.black,
              initialValue: _accountName,
              baseOffset: _accountName.length,
              height: 70,
              expands: false,
              maxLines: 1,
              value: (str) => setState(() {
                _accountName = str;
              }),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Text('Body',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.toWidth, vertical: 12.toHeight),
            child: CustomInputField(
              width: double.infinity,
              hintText: 'Enter the body',
              hintTextColor: ColorConstants.black.withOpacity(0.5),
              bgColor: Colors.transparent,
              textColor: ColorConstants.black,
              initialValue: _valueDescription,
              height: 200,
              maxLines: 2,
              expands: true,
              value: (str) => _valueDescription = str,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: RichText(
              text: TextSpan(
                text: 'Value: ',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16),
                children: [
                  TextSpan(
                    text: ' ${widget.value}',
                    style: TextStyles.lightText(ColorConstants.RED, size: 16),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Text('View',
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.toWidth, vertical: 12.toHeight),
            child: InkWell(
              onTap: () {
                _showBottomSheet(
                    onPublicClicked: () {
                      updateIsPrivate(false);
                    },
                    onPrivateClicked: () {
                      updateIsPrivate(true);
                    },
                    height: 200.toHeight);
              },
              child: _isPrivate ? _privateRow() : _publicRow(),
            ),
          ),
        ],
      ),
    );
  }

  _updateCustomContent() async {
    BasicData _customData = BasicData(
        accountName: _accountName,
        value: widget.value,
        isPrivate: _isPrivate,
        type: CustomContentType.Link.name,
        valueDescription: _valueDescription);

    print('_customData $_customData');

    LoadingDialog().show(text: 'Adding custom content');

    var _res = await AtKeySetService()
        .updateCustomFields(widget.category.label, [_customData]);

    LoadingDialog().hide();

    if (_res) {
      _showToast('$_accountName added', bgColor: ColorConstants.DARK_GREY);
      SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
    } else {
      _showToast('$_accountName addition failed', isError: true);
    }
  }

  _showBottomSheet(
      {required Function onPublicClicked,
      required Function onPrivateClicked,
      double height = 200}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? ColorConstants.white
                  : ColorConstants.black,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Select',
                    style: CustomTextStyles.customBoldTextStyle(
                        ColorConstants.black)),
                SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      onPublicClicked();
                      Navigator.of(context).pop();
                    },
                    child: _publicRow(),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      onPrivateClicked();
                      Navigator.of(context).pop();
                    },
                    child: _privateRow(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _privateRow() {
    return Row(
      children: [
        Icon(Icons.lock),
        SizedBox(width: 5.toWidth),
        Text(
          'Private',
          style: TextStyles.lightText(ColorConstants.black, size: 16),
        )
      ],
    );
  }

  Widget _publicRow() {
    return Row(
      children: [
        Icon(Icons.public),
        SizedBox(width: 5.toWidth),
        Text(
          'Public',
          style: TextStyles.lightText(ColorConstants.black, size: 16),
        )
      ],
    );
  }

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
