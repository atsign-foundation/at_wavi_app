import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeFeatured extends StatefulWidget {
  final String? twitterUsername;
  final ThemeData? themeData;
  HomeFeatured({this.twitterUsername, this.themeData});

  @override
  _HomeFeaturedState createState() => _HomeFeaturedState();
}

class _HomeFeaturedState extends State<HomeFeatured> {
  late bool _isDark;
  ThemeData? _themeData;

  @override
  void initState() {
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Instagram',
                  style:
                      TextStyles.boldText(_themeData!.primaryColor, size: 18),
                ),
                Text(
                  'See more',
                  style:
                      TextStyles.lightText(_themeData!.primaryColor, size: 16),
                ),
              ],
            ),
            SizedBox(height: 15.toHeight),
            Container(
              color: _themeData!.highlightColor.withOpacity(0.1),
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
                  style:
                      TextStyles.boldText(_themeData!.primaryColor, size: 18),
                ),
                Text(
                  'See more',
                  style:
                      TextStyles.lightText(_themeData!.primaryColor, size: 16),
                ),
              ],
            ),
            SizedBox(height: 15.toHeight),
            Column(
              children: widget.twitterUsername != null
                  ? CommonFunctions().getFeaturedTwitterCards(
                      widget.twitterUsername!, _themeData!)
                  : [],
            ),
          ],
        ),
      );
    }
  }
}
