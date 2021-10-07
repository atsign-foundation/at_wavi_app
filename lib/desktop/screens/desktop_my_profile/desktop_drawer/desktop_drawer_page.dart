import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_follow/desktop_follow_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_search_atsign/desktop_search_atsign_page.dart';
import 'package:at_wavi_app/desktop/utils/enums.dart';
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
    return widget.type == DrawerType.Search
        ? DesktopSearchAtSignPage()
        : DesktopFollowPage(
            isFollower: widget.isFollower,
          );
  }
}
