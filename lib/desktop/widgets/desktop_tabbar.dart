import 'package:flutter/material.dart';

class DesktopTabBar extends TabBar {
  DesktopTabBar({
    List<String> tabTitles = const [],
    TabController? controller,
    ValueChanged<int>? onTap,
    Color? labelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
  }) : super(
          controller: controller,
          tabs: tabTitles.map((e) => Text(e)).toList(),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          labelColor: labelColor,
          unselectedLabelStyle:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          unselectedLabelColor: unselectedLabelColor,
          indicatorSize: TabBarIndicatorSize.label,
          // indicator: ShapeDecoration(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(1),
          //     ),
          //   ),
          //   color: Colors.red,
          // ),
          indicatorColor: indicatorColor,
          indicatorWeight: 3,
          labelPadding: EdgeInsets.all(2),
          onTap: onTap,
        );
}
