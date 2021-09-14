import 'package:at_wavi_app/desktop/screens/desktop_appearance/desktop_appearance_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_home/desktop_side_menu.dart';
import 'package:at_wavi_app/desktop/screens/desktop_home/widgets/desktop_side_menu_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_home_model.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  @override
  _DesktopHomePageState createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  late DesktopHomeModel _model;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _model = DesktopHomeModel();
    super.initState();
    _model.addListener(() {
      final index = DesktopSideMenu.values.indexOf(_model.selectedMenu);
      if (index >= 0) {
        _pageController.jumpToPage(index);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => _model,
      child: Scaffold(
        body: Row(
          children: [
            buildSideMenus(),
            Container(
              width: 1,
              height: double.infinity,
              color: appTheme.separatorColor,
            ),
            Expanded(
              child: buildContentPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSideMenus() {
    final appTheme = AppTheme.of(context);
    return Consumer<DesktopHomeModel>(
      builder: (context, provider, child) {
        return Container(
          width: 360,
          margin: EdgeInsets.only(right: 1),
          child: Column(
            children: [
              Container(
                height: 150,
                child: Center(
                  child: Image.asset(
                    appTheme.isDark ? Images.logoLight : Images.logoDark,
                    width: 89,
                    height: 33,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: DesktopSideMenu.values.length,
                  itemBuilder: (context, index) {
                    final menu = DesktopSideMenu.values[index];
                    return DesktopSideMenuWidget(
                      menu: menu,
                      isSelected: menu == _model.selectedMenu,
                      onPressed: () {
                        _model.changeMenu(menu);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: appTheme.primaryLighterColor,
          ),
        );
      },
    );
  }

  Widget buildContentPage() {
    return Container(
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: DesktopSideMenu.values.map((e) {
          switch (e) {
            case DesktopSideMenu.profile:
              return Container(color: Colors.red);
            case DesktopSideMenu.basicDetails:
              return DesktopBasicDetailPage();
            case DesktopSideMenu.appearance:
              return DesktopAppearancePage();
            default:
              return Container(color: Colors.green);
          }
        }).toList(),
      ),
    );
  }
}
