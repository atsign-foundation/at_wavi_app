import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopIconLabelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final String label;

  const DesktopIconLabelButton({
    Key? key,
    required this.iconData,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: appTheme.primaryColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: appTheme.primaryColor,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
      ),
    );
  }
}
