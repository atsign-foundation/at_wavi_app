import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_notification_info_popup.dart';
import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_search_info_popup.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class DesktopProfilePrivatePage extends StatefulWidget {
  const DesktopProfilePrivatePage({Key? key}) : super(key: key);

  @override
  _DesktopProfilePrivatePageState createState() =>
      _DesktopProfilePrivatePageState();
}

class _DesktopProfilePrivatePageState extends State<DesktopProfilePrivatePage> {
  GlobalKey _searchKey = GlobalKey();
  GlobalKey _notificationKey = GlobalKey();
  GlobalKey _menuKey = GlobalKey();
  GlobalKey _editKey = GlobalKey();

  @override
  void initState() {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Showcase.withWidget(
                    key: _searchKey,
                    shapeBorder: CircleBorder(),
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
                    height: 64,
                    width: 64,
                    overlayPadding: EdgeInsets.all(8),
                    child: Container(
                      height: 36,
                      width: 36,
                      child: RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        fillColor: appTheme.borderColor,
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: appTheme.primaryTextColor,
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(context)!.dismiss();
                          ShowCaseWidget.of(context)!
                              .startShowCase([_searchKey]);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Showcase.withWidget(
                    key: _notificationKey,
                    shapeBorder: CircleBorder(),
                    container: DesktopNotificationInfoPopUp(
                      atSign: '',
                      onNext: () {
                        ShowCaseWidget.of(context)!.dismiss();
                        ShowCaseWidget.of(context)!.startShowCase([_menuKey]);
                      },
                      onCancel: () {
                        ShowCaseWidget.of(context)!.dismiss();
                      },
                    ),
                    height: 64,
                    width: 64,
                    overlayPadding: EdgeInsets.all(8),
                    child: Container(
                      height: 36,
                      width: 36,
                      child: RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        fillColor: appTheme.borderColor,
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: appTheme.primaryTextColor,
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(context)!.dismiss();
                          ShowCaseWidget.of(context)!
                              .startShowCase([_notificationKey]);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Showcase.withWidget(
                    key: _menuKey,
                    shapeBorder: CircleBorder(),
                    container: DesktopSearchInfoPopUp(
                      atSign: '',
                      icon: 'assets/images/info3.png',
                      description:
                          Strings.desktop_find_more_privacy,
                      onNext: () {
                        ShowCaseWidget.of(context)!.dismiss();
                        ShowCaseWidget.of(context)!.startShowCase([_editKey]);
                      },
                      onCancel: () {
                        ShowCaseWidget.of(context)!.dismiss();
                      },
                    ),
                    overlayPadding: EdgeInsets.all(8),
                    height: 64,
                    width: 64,
                    child: Container(
                      height: 36,
                      width: 36,
                      child: RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        fillColor: appTheme.borderColor,
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: appTheme.primaryTextColor,
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(context)!.dismiss();
                          ShowCaseWidget.of(context)!.startShowCase([_menuKey]);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Showcase.withWidget(
                    key: _editKey,
                    shapeBorder: CircleBorder(),
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
                    overlayPadding: EdgeInsets.all(8),
                    height: 64,
                    width: 64,
                    child: Container(
                      height: 36,
                      width: 36,
                      child: RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        fillColor: appTheme.borderColor,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: appTheme.primaryTextColor,
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(context)!.dismiss();
                          ShowCaseWidget.of(context)!.startShowCase([_editKey]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/private_profile.png',
                fit: BoxFit.fitWidth,
                width: 120,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                Strings.desktop_private_profile,
                style: TextStyle(
                  fontSize: 18,
                  color: appTheme.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                Strings.desktop_follow_user,
                style: TextStyle(
                  fontSize: 14,
                  color: appTheme.secondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
      autoPlay: false,
      autoPlayDelay: Duration(seconds: 3),
      autoPlayLockEnable: false,
    );
  }
}
