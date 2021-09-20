import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_follow/desktop_follow_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_follow/desktop_follower/desktop_follower_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_search/desktop_search_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/enums.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopDrawerPage extends StatefulWidget {
  DrawerType type;
  bool isFollower;

  DesktopDrawerPage({
    Key? key,
    required this.type,
    this.isFollower = true,
  }) : super(key: key);

  @override
  _DesktopDrawerPageState createState() => _DesktopDrawerPageState();
}

class _DesktopDrawerPageState extends State<DesktopDrawerPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return widget.type == DrawerType.Search
        ? DesktopSearchPage()
        : DesktopFollowPage(
            isFollower: widget.isFollower,
          );
  }
}
