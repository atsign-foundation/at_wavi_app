import 'package:at_common_flutter/services/size_config.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_onboarding_page.dart';
import 'desktop_login_page.dart';

class DesktopLoginLandingPage extends StatefulWidget {
  const DesktopLoginLandingPage({Key? key}) : super(key: key);

  @override
  _DesktopLoginLandingPageState createState() =>
      _DesktopLoginLandingPageState();
}

class _DesktopLoginLandingPageState extends State<DesktopLoginLandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: DesktopLoginPage(),
            ),
            Expanded(
              flex: 1,
              child: DesktopOnBoardingPage(),
            ),
          ],
        ),
      ),
    );
  }
}
