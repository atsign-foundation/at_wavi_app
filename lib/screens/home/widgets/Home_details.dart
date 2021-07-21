import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeDetails extends StatefulWidget {
  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Basic Details',
            style: TextStyles.boldText(_themeData.primaryColor, size: 18),
          ),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Phone Number',
                subtitle: '+1 234 567 578',
              )),
          Divider(height: 1),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Email Address',
                subtitle: 'lauren@atsign.com',
              )),
          SizedBox(height: 40.toHeight),
          Text('Additional Details',
              style: TextStyles.boldText(_themeData.primaryColor, size: 18)),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Preferred Pronoun',
                subtitle: 'He/Him',
              )),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'About',
                subtitle: 'Designer at @ Company',
              )),
        ],
      ),
    );
  }
}
