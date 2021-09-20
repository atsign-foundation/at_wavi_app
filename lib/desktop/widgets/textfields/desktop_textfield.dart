import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesktopTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  DesktopTextField({
    required this.controller,
    this.title = '',
    this.hint = '',
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: appTheme.secondaryTextColor,
            ),
          ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: appTheme.primaryTextColor,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appTheme.separatorColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appTheme.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
