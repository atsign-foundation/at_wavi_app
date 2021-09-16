import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_new_request_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_list_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopNotificationPage extends StatefulWidget {
  String atSign;

  DesktopNotificationPage({
    Key? key,
    required this.atSign,
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
    return Card(
      elevation: 3,
      child: Container(
        width: 350,
        height: 270,
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              indicatorColor: appTheme.primaryColor,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              unselectedLabelStyle: TextStyle(
                fontSize: 13,
                color: appTheme.borderColor,
              ),
              labelStyle: TextStyle(
                fontSize: 13,
                color: appTheme.primaryTextColor,
              ),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    Strings.desktop_notifications,
                  ),
                ),
                Tab(
                  child: Text(
                    Strings.desktop_new_request,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DesktopNotificationListPage(),
                  DesktopNewRequestPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
