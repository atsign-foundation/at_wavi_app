import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const DesktopButton({
    Key? key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
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
            fontSize: 16,
            color: titleColor ?? Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
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
  final Color? backgroundColor;
  final Color? borderColor;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const DesktopWhiteButton({
    Key? key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
    this.borderColor,
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
            fontSize: 16,
            color: titleColor ?? appTheme.primaryTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                color: borderColor ?? appTheme.accentColor,
                width: 1,
              ),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}
