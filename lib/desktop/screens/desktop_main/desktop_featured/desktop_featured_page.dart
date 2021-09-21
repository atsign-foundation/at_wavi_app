import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_featured/desktop_instagram_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_featured/desktop_twitter_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

class DesktopFeaturedPage extends StatefulWidget {
  const DesktopFeaturedPage({Key? key}) : super(key: key);

  @override
  _DesktopFeaturedPageState createState() => _DesktopFeaturedPageState();
}

class _DesktopFeaturedPageState extends State<DesktopFeaturedPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopFeaturedPage> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            //    indicatorColor: appTheme.primaryColor,
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
                  Strings.desktop_instagram,
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_twitter,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DesktopInstagramPage(),
                DesktopTwitterPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          currentScreen = '';
          break;
        case 1:
          currentScreen = '';
          break;
      }
    }
  }
}
