import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesktopTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final double borderRadius;
  final Color borderColor;
  final double textSize;
  final bool hasEnabledBorder;
  final bool hasFocusBorder;

  DesktopTextField({
    required this.controller,
    this.title = '',
    this.hint = '',
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
    this.backgroundColor,
    this.borderRadius = 0,
    this.textSize = 16,
    this.hasEnabledBorder = true,
    this.hasFocusBorder = true,
    this.borderColor = Colors.transparent,
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
            fontSize: textSize,
            fontWeight: FontWeight.normal,
            color: appTheme.primaryTextColor,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide.none,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: appTheme.secondaryTextColor,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
            filled: backgroundColor != null,
            fillColor: backgroundColor,
            enabledBorder: hasEnabledBorder
                ? UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    borderSide: BorderSide(color: appTheme.separatorColor),
                  )
                : null,
            focusedBorder: hasFocusBorder
                ? UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    borderSide: BorderSide(color: appTheme.primaryColor),
                  )
                : null,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
