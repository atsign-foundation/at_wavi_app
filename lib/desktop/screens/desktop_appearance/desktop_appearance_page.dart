import 'package:at_wavi_app/desktop/screens/desktop_appearance/color_setting/desktop_color_setting_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_appearance/theme_setting/desktop_theme_setting_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_tabbar.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_welcome_widget.dart';
import 'package:flutter/material.dart';

class DesktopAppearancePage extends StatefulWidget {
  const DesktopAppearancePage({Key? key}) : super(key: key);

  @override
  _DesktopAppearancePageState createState() => _DesktopAppearancePageState();
}

class _DesktopAppearancePageState extends State<DesktopAppearancePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: DesktopDimens.paddingLarge),
            Container(
              child: Center(
                child: DesktopWelcomeWidget(),
              ),
            ),
            SizedBox(height: DesktopDimens.paddingLarge),
            _buildTabBar(),
            Expanded(child: _buildPageView()),
            Container(
              padding: EdgeInsets.only(
                right: DesktopDimens.paddingLarge,
                bottom: DesktopDimens.paddingLarge,
              ),
              alignment: Alignment.bottomRight,
              child: _buildSaveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 200,
      margin: EdgeInsets.only(left: 80),
      child: DesktopTabBar(
        tabTitles: [
          'Themes',
          'Colors',
        ],
        controller: _tabController,
        onTap: (index) {
          if (_pageController.page != index) {
            _pageController.jumpToPage(index);
          }
        },
      ),
    );
  }

  Widget _buildSaveButton() {
    return DesktopButton(
      title: 'Save & Publish',
      onPressed: () {
        //Todo
      },
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        DesktopThemeSettingPage(),
        DesktopColorSettingPage(),
      ],
    );
  }
}
