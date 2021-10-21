import 'package:at_wavi_app/desktop/screens/desktop_tutorial/widgets/desktop_tutorial_info_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'widgets/desktop_tutorial_popup.dart';

enum TutorialCase {
  search,
  notification,
  menu,
  edit,
}

class DesktopTutorialPage extends StatefulWidget {
  const DesktopTutorialPage({Key? key}) : super(key: key);

  @override
  _DesktopTutorialPageState createState() => _DesktopTutorialPageState();
}

class _DesktopTutorialPageState extends State<DesktopTutorialPage> {
  TutorialCase _tutorialCase = TutorialCase.search;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          switch (_tutorialCase) {
            case TutorialCase.search:
              setState(() {
                _tutorialCase = TutorialCase.notification;
              });
              break;
            case TutorialCase.notification:
              setState(() {
                _tutorialCase = TutorialCase.menu;
              });
              break;
            case TutorialCase.menu:
              setState(() {
                _tutorialCase = TutorialCase.edit;
              });
              break;
            case TutorialCase.edit:
              Navigator.of(context).pop();
              break;
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.2),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: 166,
                child: Visibility(
                  visible: _tutorialCase == TutorialCase.search,
                  child: DesktopTutorialPopup(
                    header: DesktopIconButton(
                      iconData: Icons.search,
                      iconColor: appTheme.primaryTextColor,
                      backgroundColor: appTheme.secondaryBackgroundColor,
                    ),
                    child: DesktopTutorialInfoWidget(
                      atSign: '',
                      icon: 'assets/images/info3.png',
                      description: Strings.desktop_find_more_privacy,
                      onNext: () {
                        setState(() {
                          _tutorialCase = TutorialCase.notification;
                        });
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 102,
                child: Visibility(
                  visible: _tutorialCase == TutorialCase.notification,
                  child: DesktopTutorialPopup(
                    header: DesktopIconButton(
                      iconData: Icons.notifications,
                      iconColor: appTheme.primaryTextColor,
                      backgroundColor: appTheme.secondaryBackgroundColor,
                    ),
                    child: DesktopTutorialInfoWidget(
                      atSign: '',
                      icon: 'assets/images/info3.png',
                      description: Strings.desktop_find_more_privacy,
                      onNext: () {
                        setState(() {
                          _tutorialCase = TutorialCase.menu;
                        });
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 40,
                child: Visibility(
                  visible: _tutorialCase == TutorialCase.menu,
                  child: DesktopTutorialPopup(
                    header: DesktopIconButton(
                      iconData: Icons.more_vert,
                      iconColor: appTheme.primaryTextColor,
                      backgroundColor: appTheme.secondaryBackgroundColor,
                    ),
                    child: DesktopTutorialInfoWidget(
                      atSign: '',
                      icon: 'assets/images/info3.png',
                      description: Strings.desktop_find_more_privacy,
                      onNext: () {
                        setState(() {
                          _tutorialCase = TutorialCase.edit;
                        });
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 124,
                right: 36,
                child: Visibility(
                  visible: _tutorialCase == TutorialCase.edit,
                  child: DesktopTutorialPopup(
                    header: DesktopIconButton(
                      iconData: Icons.edit,
                      iconColor: appTheme.primaryTextColor,
                      backgroundColor: appTheme.secondaryBackgroundColor,
                      size: 36,
                    ),
                    child: DesktopTutorialInfoWidget(
                      atSign: '',
                      icon: 'assets/images/info3.png',
                      description: Strings.desktop_find_more_privacy,
                      onNext: () {
                        Navigator.of(context).pop();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
