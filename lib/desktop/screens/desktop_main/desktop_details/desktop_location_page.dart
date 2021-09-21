import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../desktop_basic_item.dart';

class DesktopLocationPage extends StatefulWidget {
  const DesktopLocationPage({Key? key}) : super(key: key);

  @override
  _DesktopLocationPageState createState() => _DesktopLocationPageState();
}

class _DesktopLocationPageState extends State<DesktopLocationPage>
    with AutomaticKeepAliveClientMixin<DesktopLocationPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
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
            title: Strings.desktop_home,
            value: '',
          ),
        ],
      ),
    );
  }
}
