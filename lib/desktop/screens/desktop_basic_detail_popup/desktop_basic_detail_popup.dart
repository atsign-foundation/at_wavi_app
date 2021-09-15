import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:flutter/material.dart';

class DesktopBasicDetailPopup extends StatefulWidget {
  const DesktopBasicDetailPopup({Key? key}) : super(key: key);

  @override
  _DesktopBasicDetailPopupState createState() =>
      _DesktopBasicDetailPopupState();
}

class _DesktopBasicDetailPopupState extends State<DesktopBasicDetailPopup> {
  final _nameTextController = TextEditingController(text: 'Lauren London');
  final _phoneTextController = TextEditingController(text: '+1 408 432 9012');
  final _emailTextController = TextEditingController(text: 'lauren@atsign.com');
  final _showHideController = ShowHideController(isShow: true);
  String _showContent = 'Show';

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
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
            'Basic Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: appTheme.primaryTextColor,
            ),
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _nameTextController,
            title: 'Name',
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _phoneTextController,
            title: 'Phone Number',
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _emailTextController,
            title: 'Email',
          ),
          SizedBox(height: 16),
          DesktopShowHideRadioButton(
            controller: _showHideController,
          ),
          SizedBox(height: 16),
          DesktopButton(
            title: 'Done',
            width: double.infinity,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
