import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_channels_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_details_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_search_info_popup.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_main_tabbar.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_showcase_widget.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'desktop_featured/desktop_featured_page.dart';

class DesktopMainDetailPage extends StatefulWidget {
  const DesktopMainDetailPage({Key? key}) : super(key: key);

  @override
  _DesktopMainDetailPageState createState() => _DesktopMainDetailPageState();
}

class _DesktopMainDetailPageState extends State<DesktopMainDetailPage> {
  GlobalKey _searchKey = GlobalKey();
  GlobalKey _notificationKey = GlobalKey();
  GlobalKey _menuKey = GlobalKey();
  GlobalKey _editKey = GlobalKey();
  late PageController _pageController;

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
                      DesktopShowCaseWidget(
                        globalKey: _searchKey,
                        container: DesktopSearchInfoPopUp(
                          atSign: '',
                          icon: 'assets/images/info1.png',
                          description: Strings.desktop_search_user,
                          onNext: () {
                            ShowCaseWidget.of(context)!.dismiss();
                            ShowCaseWidget.of(context)!
                                .startShowCase([_notificationKey]);
                          },
                          onCancel: () {
                            ShowCaseWidget.of(context)!.dismiss();
                          },
                        ),
                        iconData: Icons.search,
                      ),
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
                        DesktopDetailsPage(),
                        DesktopChannelsPage(),
                        DesktopFeaturedPage(),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: DesktopShowCaseWidget(
                        globalKey: _editKey,
                        container: DesktopSearchInfoPopUp(
                          atSign: '',
                          icon: 'assets/images/info4.png',
                          description: Strings.desktop_edit_feature,
                          onNext: () {
                            ShowCaseWidget.of(context)!.dismiss();
                          },
                          onCancel: () {
                            ShowCaseWidget.of(context)!.dismiss();
                          },
                        ),
                        iconData: Icons.edit,
                        childSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
