import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final double spacer;

  DesktopTabBar({
    this.tabTitles = const [],
    this.controller,
    this.onTap,
    this.spacer = 20,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabs: tabTitles
            .map(
              (e) => Container(
                child: Text(e),
                margin: EdgeInsets.only(bottom: 4),
              ),
            )
            .toList(),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        labelColor: appTheme.primaryTextColor,
        unselectedLabelStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        unselectedLabelColor: appTheme.secondaryTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: appTheme.primaryColor),
            insets: EdgeInsets.only(right: spacer)),
        indicatorColor: appTheme.primaryColor,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.only(right: spacer),
        enableFeedback: false,
        automaticIndicatorColorAdjustment: false,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: onTap,
      ),
    );
  }
}
