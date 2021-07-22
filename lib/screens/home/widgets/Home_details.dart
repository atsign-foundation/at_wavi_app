import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeDetails extends StatefulWidget {
  final ThemeData? themeData;
  HomeDetails({this.themeData});
  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  late bool _isDark;
  ThemeData? _themeData;

  @override
  void initState() {
    if (widget.themeData != null) {
      _themeData = widget.themeData!;
    }
    _getThemeData();
    super.initState();
  }

  _getThemeData() async {
    if (widget.themeData != null) {
      _themeData = widget.themeData!;
    } else {
      _themeData =
          await Provider.of<ThemeProvider>(context, listen: false).getTheme();
    }

    if (_themeData!.scaffoldBackgroundColor ==
        Themes.darkTheme(ColorConstants.purple).scaffoldBackgroundColor) {
      _isDark = true;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      return CircularProgressIndicator();
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Basic Details',
              style: TextStyles.boldText(_themeData!.primaryColor, size: 18),
            ),
            SizedBox(height: 15.toHeight),
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: 'Phone Number',
                  subtitle: '+1 234 567 578',
                  themeData: _themeData!,
                )),
            Divider(height: 1),
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: 'Email Address',
                  subtitle: 'lauren@atsign.com',
                  themeData: _themeData!,
                )),
            SizedBox(height: 40.toHeight),
            Text('Additional Details',
                style: TextStyles.boldText(_themeData!.primaryColor, size: 18)),
            SizedBox(height: 15.toHeight),
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: 'Preferred Pronoun',
                  subtitle: 'He/Him',
                  themeData: _themeData!,
                )),
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: 'About',
                  subtitle: 'Designer at @ Company',
                  themeData: _themeData!,
                )),
          ],
        ),
      );
    }
  }
}
