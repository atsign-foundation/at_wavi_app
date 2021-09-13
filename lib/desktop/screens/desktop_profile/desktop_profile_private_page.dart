import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_notification_info_popup.dart';
import 'package:at_wavi_app/desktop/screens/desktop_media_detail/desktop_search_info_popup.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
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
                      icon: '',
                      description: 'Search For the User Profile\nFast & Easy',
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
                          color: appTheme.accentColor,
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
                          color: appTheme.accentColor,
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
                      icon: '',
                      description:
                          'Find more about your account privacy, searchable and others functions.',
                      onNext: () {
                        ShowCaseWidget.of(context)!.dismiss();
                        ShowCaseWidget.of(context)!.startShowCase([_editKey]);
                      },
                      onCancel: () {
                        ShowCaseWidget.of(context)!.dismiss();
                      },
                    ),
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
                          color: appTheme.accentColor,
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
                      icon: '',
                      description:
                          'Edit features help you to reorder the content, add custom content',
                      onNext: () {
                        ShowCaseWidget.of(context)!.dismiss();
                      },
                      onCancel: () {
                        ShowCaseWidget.of(context)!.dismiss();
                      },
                    ),
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
                          color: appTheme.accentColor,
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
              Icon(
                Icons.computer,
                size: 100,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Private Profile',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Follow the user to know their details',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.greyText,
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
