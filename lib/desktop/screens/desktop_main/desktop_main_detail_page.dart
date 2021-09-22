import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_reorder_basic_detail/desktop_reorder_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_channels_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_details_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_search_info_popup.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_main_tabbar.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_showcase_widget.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../app.dart';
import 'desktop_featured/desktop_featured_page.dart';
import 'desktop_main_detail_model.dart';

class DesktopMainDetailPage extends StatefulWidget {
  Function onClickSearch;

  DesktopMainDetailPage({
    Key? key,
    required this.onClickSearch,
  }) : super(key: key);

  @override
  _DesktopMainDetailPageState createState() => _DesktopMainDetailPageState();
}

class _DesktopMainDetailPageState extends State<DesktopMainDetailPage> {
  GlobalKey _searchKey = GlobalKey();
  GlobalKey _notificationKey = GlobalKey();
  GlobalKey _menuKey = GlobalKey();
  GlobalKey _editKey = GlobalKey();
  late PageController _pageController;

  late DesktopMainDetailModel _model;

  DesktopDetailsPage desktopDetailsPage = DesktopDetailsPage();
  DesktopChannelsPage desktopChannelsPage = DesktopChannelsPage();
  DesktopFeaturedPage desktopFeaturedPage = DesktopFeaturedPage();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ShowCaseWidget(
      onStart: (index, key) {
        print('onStart: $index, $key');
      },
      onComplete: (index, key) {
        print('onComplete: $index, $key');
      },
      builder: Builder(
        builder: (context) => Container(
          color: ColorConstants.white,
          padding: EdgeInsets.symmetric(
            horizontal: 64,
            vertical: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  DesktopMainTabBar(
                    onSelected: (index) {
                      _pageController.animateToPage(
                        index!,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        child: RawMaterialButton(
                          shape: new CircleBorder(),
                          elevation: 0.0,
                          fillColor: appTheme.borderColor,
                          child: Icon(
                            Icons.search,
                            size: 16,
                            color: appTheme.primaryTextColor,
                          ),
                          onPressed: () {
                            widget.onClickSearch();
                          },
                        ),
                      ),
                      // DesktopShowCaseWidget(
                      //   globalKey: _searchKey,
                      //   container: DesktopSearchInfoPopUp(
                      //     atSign: '',
                      //     icon: 'assets/images/info1.png',
                      //     description: Strings.desktop_search_user,
                      //     onNext: () {
                      //       ShowCaseWidget.of(context)!.dismiss();
                      //       ShowCaseWidget.of(context)!
                      //           .startShowCase([_notificationKey]);
                      //     },
                      //     onCancel: () {
                      //       ShowCaseWidget.of(context)!.dismiss();
                      //     },
                      //   ),
                      //   iconData: Icons.search,
                      // ),
                      SizedBox(
                        width: 24,
                      ),
                      DesktopShowCaseWidget(
                        globalKey: _notificationKey,
                        container: DesktopNotificationPage(
                          atSign: '',
                          mainContext: context,
                        ),
                        iconData: Icons.notifications,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      DesktopShowCaseWidget(
                        globalKey: _menuKey,
                        container: DesktopSearchInfoPopUp(
                          atSign: '',
                          icon: 'assets/images/info3.png',
                          description: Strings.desktop_find_more_privacy,
                          onNext: () {
                            ShowCaseWidget.of(context)!.dismiss();
                            ShowCaseWidget.of(context)!
                                .startShowCase([_editKey]);
                          },
                          onCancel: () {
                            ShowCaseWidget.of(context)!.dismiss();
                          },
                        ),
                        iconData: Icons.more_vert,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int page) {},
                      controller: _pageController,
                      children: [
                        desktopDetailsPage,
                        desktopChannelsPage,
                        desktopFeaturedPage,
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 24,
                        width: 24,
                        child: RawMaterialButton(
                          shape: new CircleBorder(),
                          elevation: 0.0,
                          fillColor: appTheme.borderColor,
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: appTheme.primaryTextColor,
                          ),
                          onPressed: _clickReOrder,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: DesktopShowCaseWidget(
                    //     globalKey: _editKey,
                    //     container: DesktopSearchInfoPopUp(
                    //       atSign: '',
                    //       icon: 'assets/images/info4.png',
                    //       description: Strings.desktop_edit_feature,
                    //       onNext: () {
                    //         ShowCaseWidget.of(context)!.dismiss();
                    //       },
                    //       onCancel: () {
                    //         ShowCaseWidget.of(context)!.dismiss();
                    //       },
                    //     ),
                    //     iconData: Icons.edit,
                    //     childSize: 24,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clickReOrder() async {
    var currentScreen = await getStringFromSharedPreferences(
        key: Strings.desktop_current_screen);
    switch (currentScreen) {
      case 'DETAILS':
        await desktopDetailsPage.updateBasicDetailFields();
        break;
      case 'ADDITIONAL_DETAILS':
        await desktopDetailsPage.updateAdditionalDetailFields();
        break;
      case 'SOCIAL':
        await desktopChannelsPage.updateSocialFields();
        break;
      case 'GAMER':
        await desktopChannelsPage.updateGameFields();
        break;
    }
  }
}
