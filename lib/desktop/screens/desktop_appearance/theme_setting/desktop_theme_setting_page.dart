import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../desktop_appearance_model.dart';
import 'widgets/desktop_theme_card.dart';

class DesktopThemeSettingPage extends StatefulWidget {
  const DesktopThemeSettingPage({Key? key}) : super(key: key);

  @override
  _DesktopThemeSettingPageState createState() =>
      _DesktopThemeSettingPageState();
}

class _DesktopThemeSettingPageState extends State<DesktopThemeSettingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final desktopAppearanceModel = Provider.of<DesktopAppearanceModel>(
      context,
    );
    return Container(
      padding: EdgeInsets.only(
          left: DesktopDimens.marginExtraLarge, top: DesktopDimens.marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 166,
                child: DesktopThemeCard(
                  primaryColor: desktopAppearanceModel.color,
                  brightness: Brightness.light,
                  isSelected: !desktopAppearanceModel.isDarkMode,
                  onPressed: () {
                    desktopAppearanceModel.changeDarkMode(false);
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 166,
                child: DesktopThemeCard(
                  primaryColor: desktopAppearanceModel.color,
                  brightness: Brightness.dark,
                  isSelected: desktopAppearanceModel.isDarkMode,
                  onPressed: () {
                    desktopAppearanceModel.changeDarkMode(true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
