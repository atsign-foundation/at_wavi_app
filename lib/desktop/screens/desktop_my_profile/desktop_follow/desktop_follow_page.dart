import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_tabbar.dart';
import 'package:flutter/material.dart';

import 'desktop_follower/desktop_follower_page.dart';
import 'desktop_following/desktop_following_page.dart';

class DesktopFollowPage extends StatefulWidget {
  bool isFollower;

  DesktopFollowPage({
    Key? key,
    this.isFollower = true,
  }) : super(key: key);

  @override
  _DesktopFollowPageState createState() => _DesktopFollowPageState();
}

class _DesktopFollowPageState extends State<DesktopFollowPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopFollowPage> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.isFollower ? 0 : 1,
    );
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 360,
      color: appTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: DesktopTabBar(
              controller: _tabController,
              tabTitles: [
                Strings.desktop_followers,
                Strings.desktop_following,
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DesktopFollowerPage(),
                DesktopFollowingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
