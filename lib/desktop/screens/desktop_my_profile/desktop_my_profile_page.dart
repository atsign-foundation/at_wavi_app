import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_settings/desktop_settings_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_user_profile/desktop_profile_info_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/enums.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'desktop_drawer/desktop_drawer_page.dart';
import 'desktop_main_detail_page.dart';

class DesktopMyProfilePage extends StatefulWidget {
  DesktopMyProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _DesktopMyProfilePageState createState() => _DesktopMyProfilePageState();
}

class _DesktopMyProfilePageState extends State<DesktopMyProfilePage> {
  final _globalKey = GlobalKey<ScaffoldState>();
  final _parentScaffoldKey = GlobalKey<ScaffoldState>();
  DrawerType drawerType = DrawerType.Search;
  bool isFollower = true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      key: _parentScaffoldKey,
      endDrawer: DesktopSettingsPage(),
      body: Scaffold(
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
                  color: appTheme.separatorColor,
                ),
                Expanded(
                  child: DesktopMainDetailPage(
                    onSearchPressed: (){
                      _globalKey.currentState?.openEndDrawer();
                    },
                    onSettingPressed: () {
                      _parentScaffoldKey.currentState?.openEndDrawer();
                      // drawerType = DrawerType.Search;
                      // setState(() {});
                      // Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
