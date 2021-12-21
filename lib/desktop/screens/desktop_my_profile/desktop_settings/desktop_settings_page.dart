import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_wavi_app/common_components/switch_at_sign.dart';
import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/screens/options.dart';
import 'package:at_wavi_app/services/change_privacy_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/desktop_setting_switch_widget.dart';
import 'widgets/desktop_setting_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopSettingsPage extends StatefulWidget {
  const DesktopSettingsPage({Key? key}) : super(key: key);

  @override
  _DesktopSettingsPageState createState() => _DesktopSettingsPageState();
}

class _DesktopSettingsPageState extends State<DesktopSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final isPrivateAccount =
        Provider.of<UserProvider>(context).user?.allPrivate ?? false;
    final isUpdating = Provider.of<SetPrivateState>(context).isLoading;
    return Container(
      width: DesktopDimens.sideMenuWidth,
      color: appTheme.backgroundColor,
      child: Column(
        children: [
          SizedBox(height: DesktopDimens.paddingLarge),
          DesktopSettingSwitchWidget(
            prefixIcon: Icons.lock_rounded,
            title: "Make all information private",
            isOn: isPrivateAccount,
            isUpdating: isUpdating,
            onChanged: (isOn) async {
              final user =
                  Provider.of<UserProvider>(context, listen: false).user;
              if (user != null) {
                await ChangePrivacyService().setAllPrivate(isOn, user);
              }
            },
          ),
          // DesktopSettingSwitchWidget(
          //   prefixIcon: Icons.remove_red_eye_rounded,
          //   title: "Exclude your @wavi from search results",
          // ),
          // DesktopSettingWidget(
          //   prefixIcon: Icons.south_west_rounded,
          //   title: "Import",
          // ),
          // DesktopSettingWidget(
          //   prefixIcon: Icons.north_east_rounded,
          //   title: "Export",
          // ),
          DesktopSettingWidget(
            prefixIcon: Icons.library_books_outlined,
            title: "Terms and Condition",
            onTapped: onTOSTapped,
          ),
          DesktopSettingWidget(
            prefixIcon: Icons.forum,
            title: "FAQs",
            onTapped: onFAQTapped,
          ),
          // DesktopSettingWidget(
          //   prefixIcon: Icons.delete,
          //   title: "Delete @sign",
          //   onPressed: onSwitchAccountTapped,
          // ),
          DesktopSettingWidget(
            prefixIcon: Icons.logout,
            title: "Switch @sign",
            onTapped: onSwitchAccountTapped,
          ),
        ],
      ),
    );
  }

  void onTOSTapped() {
    launch('${MixedConstants.WEBSITE_URL}/terms-conditions');
  }

  void onFAQTapped() {
    launch('${MixedConstants.WEBSITE_URL}/faqs');
  }

  void onSwitchAccountTapped() async {
    var atSignList = await KeychainUtil.getAtsignList();
    final result = await showModalBottomSheet(
      context: NavService.navKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) => AtSignBottomSheet(
        atSignList: atSignList ?? [],
        onSuccess: () {
          Navigator.pop(context, 'atSign_changed');
          // SetupRoutes.pushAndRemoveAll(NavService.navKey.currentContext!,
          //     DesktopRoutes.DESKTOP_MY_PROFILE);
        },
      ),
    );
    if (result == 'atSign_changed') {
      Navigator.pop(context);
    }
  }
}
