import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../desktop_basic_item.dart';

class DesktopGameAccountPage extends StatefulWidget {
  const DesktopGameAccountPage({Key? key}) : super(key: key);

  @override
  _DesktopGameAccountPageState createState() => _DesktopGameAccountPageState();
}

class _DesktopGameAccountPageState extends State<DesktopGameAccountPage>
    with AutomaticKeepAliveClientMixin<DesktopGameAccountPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorConstants.LIGHT_GREY,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DesktopBasicItem(
                title: Strings.desktop_ps4,
                value: 'ducpham',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_xbox,
                value: 'ducpham',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_twitch,
                value: 'twitch.tv/ducpham',
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
