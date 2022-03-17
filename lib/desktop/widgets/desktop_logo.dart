import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopLogo extends StatelessWidget {
  const DesktopLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Image.asset(
      appTheme.isDark ? Images.logoLight : Images.logoDark,
      width: 68,
      height: 28,
    );
  }
}
