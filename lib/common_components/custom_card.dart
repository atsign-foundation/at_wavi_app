import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:at_wavi_app/services/size_config.dart';

class CustomCard extends StatelessWidget {
  final String? title, subtitle;
  final bool isUrl;
  late bool _isDark;
  late ThemeData themeData;
  CustomCard(
      {this.title,
      required this.subtitle,
      this.isUrl = false,
      required this.themeData});

  void setThemeData(BuildContext context) {
    _isDark = themeData.scaffoldBackgroundColor == ColorConstants.black;
  }

  @override
  Widget build(BuildContext context) {
    setThemeData(context);
    return Container(
      color: themeData.highlightColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title != null
                ? Text(
                    title!,
                    style: TextStyles.lightText(
                        themeData.primaryColor.withOpacity(0.5),
                        size: 16),
                  )
                : SizedBox(),
            SizedBox(height: 6),
            subtitle != null
                ? Html(
                    data: subtitle,
                    style: {
                      'body': Style(
                        color: isUrl
                            ? ColorConstants.orange
                            : _isDark
                                ? themeData.primaryColor
                                : themeData.highlightColor,
                        fontSize: FontSize(18.toFont),
                        padding: EdgeInsets.all(0),
                      )
                    },
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
