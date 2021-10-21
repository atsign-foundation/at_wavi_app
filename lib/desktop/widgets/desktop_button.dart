import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double width;
  final double height;
  final double textSize;
  final VoidCallback? onPressed;

  const DesktopButton({
    Key? key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 5,
    this.textSize = 16,
    this.width = 184,
    this.height = 56,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: textSize,
            color: titleColor ?? Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: 0.5,
              ),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? appTheme.secondaryColor),
        ),
      ),
    );
  }
}

class DesktopWhiteButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? borderColor;
  final double width;
  final double height;
  final double textSize;
  final VoidCallback? onPressed;

  const DesktopWhiteButton({
    Key? key,
    required this.title,
    this.titleColor,
    this.borderColor,
    this.textSize = 16,
    this.width = 184,
    this.height = 56,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final isDark = appTheme.isDark;
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: textSize,
            color: titleColor ?? appTheme.primaryTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                color: borderColor ??
                    (isDark ? Colors.white : appTheme.accentColor),
                width: 0.5,
              ),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
              isDark ? Colors.transparent : ColorConstants.white),
        ),
      ),
    );
  }
}
