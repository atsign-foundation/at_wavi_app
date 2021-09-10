import 'package:at_wavi_app/app.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/desktop_color_card.dart';

class DesktopColorSettingPage extends StatefulWidget {
  const DesktopColorSettingPage({Key? key}) : super(key: key);

  @override
  _DesktopColorSettingPageState createState() =>
      _DesktopColorSettingPageState();
}

class _DesktopColorSettingPageState extends State<DesktopColorSettingPage>
    with AutomaticKeepAliveClientMixin {
  List<Color> primaryColors = ColorConstants.desktopPrimaryColors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Colour",
            style: TextStyle().copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  primaryColors.length,
                  (index) {
                    return DesktopColorCard(
                      color: primaryColors[index],
                      isSelected:
                          primaryColors[index] == appTheme.primaryColor,
                      onPressed: () {
                        setState(() {
                          final newTheme = AppTheme.from(
                            primaryColor: primaryColors[index],
                            brightness: appTheme.brightness,
                          );
                          appThemeController.sink.add(newTheme);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
