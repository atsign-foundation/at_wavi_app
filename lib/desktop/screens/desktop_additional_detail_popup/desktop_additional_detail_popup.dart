import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:flutter/material.dart';

class DesktopAdditionalDetailPopup extends StatefulWidget {
  const DesktopAdditionalDetailPopup({Key? key}) : super(key: key);

  @override
  _DesktopAdditionalDetailPopupState createState() =>
      _DesktopAdditionalDetailPopupState();
}

class _DesktopAdditionalDetailPopupState extends State<DesktopAdditionalDetailPopup> {
  final _preferredPronounTextController = TextEditingController(text: 'Her / She');
  final _aboutTextController = TextEditingController(text: 'Hello');
  final _quoteTextController = TextEditingController(text: 'Loading');
  final _showHideController = ShowHideController(isShow: true);

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
            'Additional Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: appTheme.primaryTextColor,
            ),
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _preferredPronounTextController,
            title: 'Preferred Pronoun',
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _aboutTextController,
            title: 'About',
          ),
          SizedBox(height: 16),
          DesktopTextField(
            controller: _quoteTextController,
            title: 'Quote',
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
