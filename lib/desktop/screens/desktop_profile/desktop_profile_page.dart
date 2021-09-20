import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_profile_info_page.dart';
import 'desktop_profile_private_page.dart';

class DesktopProfilePage extends StatefulWidget {
  const DesktopProfilePage({Key? key}) : super(key: key);

  @override
  _DesktopProfilePageState createState() => _DesktopProfilePageState();
}

class _DesktopProfilePageState extends State<DesktopProfilePage> {
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
                isMyProfile: false,
              ),
            ),
            Container(
              width: 1,
              color: ColorConstants.lightGrey,
            ),
            Expanded(
              child: DesktopProfilePrivatePage(),
            ),
          ],
        ),
      ),
    );
  }
}
