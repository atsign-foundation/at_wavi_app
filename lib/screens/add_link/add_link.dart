import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AddLink extends StatefulWidget {
  const AddLink({Key? key}) : super(key: key);

  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  List<String> _sections = [
    'Basic Details',
    'Additional Details',
    'Location',
    'Social Channel',
    'Game Channel',
    'Featured Content'
  ];

  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomSheet: InkWell(
        onTap: _selectedValue == '' ? null : () {},
        child: Container(
            alignment: Alignment.center,
            height: 70.toHeight,
            width: SizeConfig().screenWidth,
            color: _selectedValue == ''
                ? ColorConstants.dullColor
                : Theme.of(context).primaryColor,
            child: Text(
              'Next',
              style: CustomTextStyles.customTextStyle(
                  Theme.of(context).scaffoldBackgroundColor,
                  size: 18),
            )),
      ),
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'Select a section',
          style: CustomTextStyles.customBoldTextStyle(
              Theme.of(context).primaryColor,
              size: 16),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView.separated(
          itemBuilder: (context, _index) {
            return _radioButtons(_sections[_index]);
          },
          separatorBuilder: (context, _index) {
            return Divider();
          },
          itemCount: _sections.length),
    );
  }

  Widget _radioButtons(String _value) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 4.toHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$_value',
            style: CustomTextStyles.customTextStyle(
                Theme.of(context).primaryColor,
                size: 16),
          ),
          Transform.scale(
            scale: 1.4,
            child: Radio(
              value: _value,
              groupValue: _selectedValue,
              activeColor: Theme.of(context).primaryColor,
              splashRadius: 5,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                setState(() {
                  _selectedValue = _value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
