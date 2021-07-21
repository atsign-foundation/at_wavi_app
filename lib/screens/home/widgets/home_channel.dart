import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeChannels extends StatefulWidget {
  @override
  _HomeChannelsState createState() => _HomeChannelsState();
}

class _HomeChannelsState extends State<HomeChannels> {
  late bool _isDark;
  late ThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    _isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    if (_isDark) {
      _themeData = Themes.darkTheme;
    } else {
      _themeData = Themes.lightTheme;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '@apps',
            style: TextStyles.boldText(_themeData.primaryColor, size: 18),
          ),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15),
                color: _themeData.highlightColor.withOpacity(0.1),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.app_blocking, size: 35),
                    Icon(Icons.app_blocking, size: 35),
                  ],
                ),
              )),
          SizedBox(height: 40.toHeight),
          Text(
            'Social Accounts',
            style: TextStyles.boldText(_themeData.primaryColor, size: 18),
          ),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Facebook',
                subtitle: 'fb.com/laurenlondon',
                isUrl: true,
              )),
          Divider(height: 1),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Twitter',
                subtitle: 'twitter.com/laurenlondon',
                isUrl: true,
              )),
          SizedBox(height: 40.toHeight),
          Text(
            'Game Accounts',
            style: TextStyles.boldText(_themeData.primaryColor, size: 18),
          ),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'PS4',
                subtitle: 'tackojohnlauren',
              )),
          Divider(height: 1),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Xbox',
                subtitle: 'tackolauren',
              )),
        ],
      ),
    );
  }
}
