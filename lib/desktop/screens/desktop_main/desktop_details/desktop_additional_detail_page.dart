import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

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
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_preferred_pronoun,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'He/Him',
                        style: TextStyle(
                            fontSize: 14,
                            color: appTheme.primaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_about,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'Design at @Company',
                        style: TextStyle(
                            fontSize: 14,
                            color: appTheme.primaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_quote,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'Let us make our futute now.',
                        style: TextStyle(
                            fontSize: 14,
                            color: appTheme.primaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: appTheme.borderColor,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        Strings.desktop_video,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: 14,
                            color: appTheme.primaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
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
