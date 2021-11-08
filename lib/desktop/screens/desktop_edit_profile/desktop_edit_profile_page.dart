import 'package:at_wavi_app/desktop/screens/desktop_appearance/desktop_appearance_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_profile_details/desktop_media/desktop_media_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_profile_basic_info_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_edit_profile/desktop_profile_picture/desktop_profile_picture_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_logo.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_edit_profile_model.dart';
import 'desktop_side_menu.dart';
import 'widgets/desktop_side_menu_widget.dart';

class DesktopEditProfilePage extends StatefulWidget {
  const DesktopEditProfilePage({Key? key}) : super(key: key);

  @override
  _DesktopEditProfilePageState createState() => _DesktopEditProfilePageState();
}

class _DesktopEditProfilePageState extends State<DesktopEditProfilePage> {
  late DesktopEditProfileModel _model;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _model = DesktopEditProfileModel();
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
    return Consumer<DesktopEditProfileModel>(
      builder: (context, provider, child) {
        return Container(
          width: DesktopDimens.sideMenuWidth,
          margin: EdgeInsets.only(right: 1),
          child: Column(
            children: [
              Container(
                height: 120,
                child: Stack(
                  children: [
                    Center(
                      child: DesktopLogo(),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: DesktopIconButton(
                        iconData: Icons.close_rounded,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
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
    final appTheme = AppTheme.of(context);
    return Container(
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: DesktopSideMenu.values.map((e) {
          switch (e) {
            case DesktopSideMenu.profile:
              // chua co
              return DesktopProfilePicturePage();
            case DesktopSideMenu.media:
              return DesktopMediaPage();
            case DesktopSideMenu.basicDetails:
              return DesktopProfileBasicInfoPage(
                atCategory: AtCategory.DETAILS,
                isMyProfile: true,
                isEditable: true,
              );
            case DesktopSideMenu.additionalDetails:
              return DesktopProfileBasicInfoPage(
                atCategory: AtCategory.ADDITIONAL_DETAILS,
                isMyProfile: true,
                isEditable: true,
              );
            case DesktopSideMenu.location:
              return DesktopProfileBasicInfoPage(
                atCategory: AtCategory.LOCATION,
                isMyProfile: true,
                isEditable: true,
              );
            case DesktopSideMenu.socialChannel:
              return DesktopProfileBasicInfoPage(
                atCategory: AtCategory.SOCIAL,
                isMyProfile: true,
                isEditable: true,
              );
            case DesktopSideMenu.gameChannel:
              return DesktopProfileBasicInfoPage(
                atCategory: AtCategory.GAMER,
                isMyProfile: true,
                isEditable: true,
              );
            // case DesktopSideMenu.featuredChannel:
            //   return DesktopProfileBasicInfoPage(atCategory: AtCategory.FEATURED);
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
