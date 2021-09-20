import 'package:at_wavi_app/desktop/screens/desktop_profile/desktop_profile_info_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_main_detail_page.dart';

class DesktopMainPage extends StatefulWidget {
  const DesktopMainPage({Key? key}) : super(key: key);

  @override
  _DesktopMainPageState createState() => _DesktopMainPageState();
}

class _DesktopMainPageState extends State<DesktopMainPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Container(
        child: Row(
          children: [
            Container(
              width: 360,
              child: DesktopProfileInfoPage(
                isMyProfile: true,
              ),
            ),
            Container(
              width: 1,
              color: ColorConstants.lightGrey,
            ),
            Expanded(
              child: DesktopMainDetailPage(),
            ),
          ],
        ),
      ),
    );
  }
}
