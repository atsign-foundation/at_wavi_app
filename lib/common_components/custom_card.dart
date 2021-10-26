import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/services/size_config.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
      color: themeData.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title != null
                ? Text(
                    '${title![0].toUpperCase()}${title!.substring(1)}',
                    style: TextStyles.lightText(
                        _isDark
                            ? themeData.primaryColor.withOpacity(0.5)
                            : themeData.highlightColor.withOpacity(0.7),
                        size: 16),
                  )
                : SizedBox(),
            SizedBox(height: 6),
            subtitle != null
                ? GestureDetector(
                    onTap: () {
                      if (!isUrl) {
                        return;
                      }
                      SetupRoutes.push(context, Routes.WEB_VIEW,
                          arguments: {'title': title, 'url': subtitle});
                    },
                    child: HtmlWidget(
                      subtitle!,
                      textStyle: TextStyle(
                        color: isUrl
                            ? ColorConstants.orange
                            : _isDark
                                ? themeData.primaryColor
                                : themeData.highlightColor,
                        fontSize: 16.toFont,
                      ),
                      webView: true,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
