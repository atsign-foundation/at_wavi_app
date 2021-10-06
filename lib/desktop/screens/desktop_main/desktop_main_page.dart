import 'package:at_wavi_app/desktop/screens/desktop_profile/desktop_profile_info_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/enums.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_drawer/desktop_drawer_page.dart';
import 'desktop_main_detail_page.dart';

class DesktopMainPage extends StatefulWidget {
  DesktopMainPage({
    Key? key,
  }) : super(key: key);

  @override
  _DesktopMainPageState createState() => _DesktopMainPageState();
}

class _DesktopMainPageState extends State<DesktopMainPage> {
  GlobalKey _globalKey = GlobalKey();
  DrawerType drawerType = DrawerType.Search;
  bool isFollower = true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      key: _globalKey,
      backgroundColor: ColorConstants.white,
      endDrawer: Drawer(
        child: DesktopDrawerPage(
          type: drawerType,
          isFollower: isFollower,
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          child: Row(
            children: [
              Container(
                width: 360,
                child: DesktopProfileInfoPage(
                  atSign: '',
                  //Todo
                  // isMyProfile: true,
                  // onClickFollow: (title) {
                  //   drawerType = DrawerType.Follow;
                  //   isFollower = title == Strings.desktop_followers;
                  //   setState(() {});
                  //   Scaffold.of(context).openEndDrawer();
                  // },
                ),
              ),
              Container(
                width: 1,
                color: ColorConstants.lightGrey,
              ),
              Expanded(
                child: DesktopMainDetailPage(
                  onClickSearch: () {
                    drawerType = DrawerType.Search;
                    setState(() {});
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
