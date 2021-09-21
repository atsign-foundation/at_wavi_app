import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../desktop_basic_item.dart';

class DesktopAdditionalDetailPage extends StatefulWidget {
  const DesktopAdditionalDetailPage({Key? key}) : super(key: key);

  @override
  _DesktopAdditionalDetailPageState createState() =>
      _DesktopAdditionalDetailPageState();
}

class _DesktopAdditionalDetailPageState
    extends State<DesktopAdditionalDetailPage>
    with AutomaticKeepAliveClientMixin<DesktopAdditionalDetailPage> {
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
                title: Strings.desktop_preferred_pronoun,
                value: 'He/Him',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_about,
                value: 'Design at @Company',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_quote,
                value: 'Let us make our future now.',
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              DesktopBasicItem(
                title: Strings.desktop_video,
                value: '',
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
