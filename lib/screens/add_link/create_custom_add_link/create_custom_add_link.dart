import 'package:at_wavi_app/common_components/custom_input_field.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CreateCustomAddLink extends StatefulWidget {
  const CreateCustomAddLink({Key? key}) : super(key: key);

  @override
  _CreateCustomAddLinkState createState() => _CreateCustomAddLinkState();
}

class _CreateCustomAddLinkState extends State<CreateCustomAddLink> {
  String _valueDescription = '', _accountName = '';
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomSheet: InkWell(
        onTap: (_accountName == '')
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: ColorConstants.RED,
                  content: Text(
                    'Enter title',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
              }
            : () {},
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
              initialValue: '',
              height: 200,
              maxLines: 2,
              expands: true,
              value: (str) => _valueDescription = str,
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
            child: Row(
              children: [
                Icon(Icons.public),
                SizedBox(width: 5.toWidth),
                Text(
                  'Public',
                  style: TextStyles.lightText(ColorConstants.black, size: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
