import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_new_request_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_list_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopNotificationPage extends StatefulWidget {
  String atSign;
  BuildContext mainContext;

  DesktopNotificationPage({
    Key? key,
    required this.atSign,
    required this.mainContext,
  }) : super(key: key);

  @override
  _DesktopNotificationPageState createState() =>
      _DesktopNotificationPageState();
}

class _DesktopNotificationPageState extends State<DesktopNotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 400,
      height: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorColor: appTheme.primaryColor,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
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
                  Strings.desktop_notifications,
                  style: TextStyle(
                    fontSize: 13,
                    color: appTheme.primaryTextColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_new_request,
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
                DesktopNotificationListPage(
                  mainContext: widget.mainContext,
                ),
                DesktopNewRequestPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
