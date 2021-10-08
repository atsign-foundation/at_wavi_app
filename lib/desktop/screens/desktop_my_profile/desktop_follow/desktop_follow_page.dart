import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
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
      width: 380,
      color: appTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: appTheme.primaryColor,
              ),
              insets: EdgeInsets.only(
                left: 0,
                right: 8,
                bottom: 4,
              ),
            ),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(
              fontSize: 13,
              color: appTheme.borderColor,
              fontFamily: 'Inter',
            ),
            labelStyle: TextStyle(
              fontSize: 13,
              color: appTheme.primaryTextColor,
              fontFamily: 'Inter',
            ),
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  Strings.desktop_followers,
                  style: TextStyle(
                    fontSize: 13,
                    color: appTheme.primaryTextColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_following,
                  style: TextStyle(
                    fontSize: 13,
                    color: appTheme.primaryTextColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
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
