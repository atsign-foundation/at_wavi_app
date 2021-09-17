import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_additional_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_location_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_media_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopDetailsPage extends StatefulWidget {
  const DesktopDetailsPage({Key? key}) : super(key: key);

  @override
  _DesktopDetailsPageState createState() => _DesktopDetailsPageState();
}

class _DesktopDetailsPageState extends State<DesktopDetailsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopDetailsPage> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
                  Strings.desktop_media,
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_basic_details,
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_additional_details,
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_location,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DesktopMediaPage(),
                DesktopBasicDetailPage(),
                DesktopAdditionalDetailPage(),
                DesktopLocationPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
