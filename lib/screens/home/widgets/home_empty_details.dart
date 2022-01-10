import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:provider/provider.dart';

class HomeEmptyDetails extends StatefulWidget {
  final ThemeData? themeData;
  HomeEmptyDetails({this.themeData});
  @override
  _HomeEmptyDetailsState createState() => _HomeEmptyDetailsState();
}

class _HomeEmptyDetailsState extends State<HomeEmptyDetails> {
  ThemeData? _themeData;
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

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text('Edit your profile', style:TextStyle(
      fontSize: 18.toFont, color: _themeData!.primaryColor, fontWeight: FontWeight.bold) ),
            SizedBox(height: 10.toHeight),
            Text(
              '''
Edit your profile and add details to start 
sharing your profile with others.''',
              style: TextStyles.grey15,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.toHeight),
            GestureDetector(
              onTap: () {
                SetupRoutes.push(
                    NavService.navKey.currentContext!, Routes.EDIT_PERSONA);
              },
              child: Text('Add Details', style: TextStyles.orange18bold),
            ),
          ],
        ),
      ),
    );
  }
}
