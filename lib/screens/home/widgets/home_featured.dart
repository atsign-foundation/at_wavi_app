import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeFeatured extends StatefulWidget {
  @override
  _HomeFeaturedState createState() => _HomeFeaturedState();
}

class _HomeFeaturedState extends State<HomeFeatured> {
  late bool _isDark;
  late ThemeData _themeData;

  void setThemeData() {
    _isDark = isDarkModeEnabled(context);
    if (_isDark) {
      _themeData = Themes.darkTheme;
    } else {
      _themeData = Themes.lightTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    setThemeData();
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Instagram',
                style: TextStyles.boldText(_themeData.primaryColor, size: 18),
              ),
              Text(
                'See more',
                style: TextStyles.lightText(_themeData.primaryColor, size: 16),
              ),
            ],
          ),
          SizedBox(height: 15.toHeight),
          Container(
            color: _themeData.highlightColor.withOpacity(0.1),
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                runSpacing: 10.0,
                spacing: 20.0,
                children: List.generate(6, (index) {
                  return Icon(
                    Icons.image,
                    size: 80,
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 40.toHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Twitter',
                style: TextStyles.boldText(_themeData.primaryColor, size: 18),
              ),
              Text(
                'See more',
                style: TextStyles.lightText(_themeData.primaryColor, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
