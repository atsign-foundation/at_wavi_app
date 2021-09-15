import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_login_guide_page.dart';
import 'desktop_login_page.dart';

class DesktopLoginLandingPage extends StatefulWidget {
  const DesktopLoginLandingPage({Key? key}) : super(key: key);

  @override
  _DesktopLoginLandingPageState createState() =>
      _DesktopLoginLandingPageState();
}

class _DesktopLoginLandingPageState extends State<DesktopLoginLandingPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: DesktopLoginPage(),
            ),
            Container(
              width: 1,
              color: appTheme.borderColor,
            ),
            Expanded(
              flex: 1,
              child: DesktopLoginGuidePage(),
            ),
          ],
        ),
      ),
    );
  }
}
