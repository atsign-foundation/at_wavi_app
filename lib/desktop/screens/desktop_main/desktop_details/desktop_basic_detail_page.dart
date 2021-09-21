import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../desktop_basic_item.dart';

class DesktopBasicDetailPage extends StatefulWidget {
  const DesktopBasicDetailPage({Key? key}) : super(key: key);

  @override
  _DesktopBasicDetailPageState createState() => _DesktopBasicDetailPageState();
}

class _DesktopBasicDetailPageState extends State<DesktopBasicDetailPage>
    with AutomaticKeepAliveClientMixin<DesktopBasicDetailPage> {
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
                title: Strings.desktop_phone_number,
                value: '+84 3354335562',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_email_address,
                value: 'duc1@gmail.com',
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
