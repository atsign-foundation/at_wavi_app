import 'package:at_wavi_app/common_components/switch_at_sign.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
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
            title: "Private Account",
          ),
          DesktopSettingSwitchWidget(
            prefixIcon: Icons.remove_red_eye_rounded,
            title: "Searchable Account",
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
          InkWell(
            onTap: () async {
              var atSignList = await KeychainUtil.getAtsignList();

              await showModalBottomSheet(
                context: NavService.navKey.currentContext!,
                backgroundColor: Colors.transparent,
                builder: (context) => AtSignBottomSheet(
                  atSignList: atSignList ?? [],
                ),
              );
            },
            child: DesktopSettingWidget(
              prefixIcon: Icons.logout,
              title: "Switch @sign",
            ),
          ),
        ],
      ),
    );
  }
}
