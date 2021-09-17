import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final double size;

  const DesktopIconButton({
    Key? key,
    required this.iconData,
    this.onPressed,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(
          iconData,
          color: appTheme.primaryColor,
          size: size / 2,
        ),
        elevation: 0,
        backgroundColor: appTheme.primaryLighterColor,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
    );
  }
}
