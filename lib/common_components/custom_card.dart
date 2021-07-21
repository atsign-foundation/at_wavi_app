import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  final String title, subtitle;
  final bool isUrl;
  late bool _isDark;
  late ThemeData _themeData;
  CustomCard({required this.title, required this.subtitle, this.isUrl = false});
  @override
  Widget build(BuildContext context) {
    _isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    if (_isDark) {
      _themeData = Themes.darkTheme;
    } else {
      _themeData = Themes.lightTheme;
    }
    return Container(
      color: _themeData.highlightColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: _isDark
                  ? TextStyles.lightText(Colors.white.withOpacity(0.5),
                      size: 16)
                  : TextStyles.lightText(Colors.black.withOpacity(0.5),
                      size: 16),
            ),
            SizedBox(height: 6),
            Text(
              subtitle,
              style: isUrl
                  ? TextStyles.lightText(ColorConstants.orange, size: 18)
                  : _isDark
                      ? TextStyles.lightText(Colors.white, size: 18)
                      : TextStyles.lightText(_themeData.highlightColor,
                          size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
