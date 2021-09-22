import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class DesktopShowCaseWidget extends StatelessWidget {
  GlobalKey globalKey;
  Widget container;
  IconData iconData;
  double iconSize;
  double childSize;
  double overlayOpacity;
  Color overlayColor;

  DesktopShowCaseWidget({
    Key? key,
    required this.globalKey,
    required this.container,
    required this.iconData,
    this.overlayOpacity = 0.75,
    this.overlayColor = Colors.black,
    this.iconSize = 16,
    this.childSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Showcase.withWidget(
      key: globalKey,
      shapeBorder: CircleBorder(),
      disableAnimation: true,
      container: container,
      overlayPadding: EdgeInsets.all(6),
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      height: childSize * 1.5,
      width: childSize * 1.5,
      child: Container(
        height: childSize,
        width: childSize,
        child: RawMaterialButton(
          shape: new CircleBorder(),
          elevation: 0.0,
          fillColor: appTheme.borderColor,
          child: Icon(
            iconData,
            size: iconSize,
            color: appTheme.primaryTextColor,
          ),
          onPressed: () {
            ShowCaseWidget.of(context)!.dismiss();
            ShowCaseWidget.of(context)!.startShowCase([globalKey]);
          },
        ),
      ),
    );
  }
}
