import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title, subtitle;
  final bool isUrl;
  late bool _isDark;
  late ThemeData themeData;
  CustomCard(
      {required this.title,
      required this.subtitle,
      this.isUrl = false,
      required this.themeData});

  void setThemeData(BuildContext context) {
    _isDark = themeData.scaffoldBackgroundColor == ColorConstants.white;
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
            Text(
              title,
              style: TextStyles.lightText(
                  themeData.primaryColor.withOpacity(0.5),
                  size: 16),
            ),
            SizedBox(height: 6),
            Text(
              subtitle,
              style: isUrl
                  ? TextStyles.lightText(ColorConstants.orange, size: 18)
                  : _isDark
                      ? TextStyles.lightText(themeData.primaryColor, size: 18)
                      : TextStyles.lightText(themeData.highlightColor,
                          size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
