import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'widgets/desktop_setting_switch_widget.dart';
import 'widgets/desktop_setting_widget.dart';

class DesktopSettingsPage extends StatefulWidget {
  const DesktopSettingsPage({Key? key}) : super(key: key);

  @override
  _DesktopSettingsPageState createState() => _DesktopSettingsPageState();
}

class _DesktopSettingsPageState extends State<DesktopSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 380,
      color: appTheme.backgroundColor,
      child: Column(
        children: [
          SizedBox(height: 60),
          DesktopSettingSwitchWidget(
            prefixIcon: Icons.lock_rounded,
            title: "Make all information private",
          ),
          DesktopSettingSwitchWidget(
            prefixIcon: Icons.remove_red_eye_rounded,
            title: "Exclude your @wavi from search results",
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.south_west_rounded,
            title: "Import",
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.north_east_rounded,
            title: "Export",
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.library_books_outlined,
            title: "Terms and Condition",
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.forum,
            title: "FAQs",
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.logout,
            title: "Switch @sign",
          ),
        ],
      ),
    );
  }
}
