import 'package:at_wavi_app/desktop/screens/desktop_notification/item/desktop_notification_item.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopNotificationInfoPopUp extends StatefulWidget {
  String atSign;
  final Function onNext;
  final Function onCancel;

  DesktopNotificationInfoPopUp({
    Key? key,
    required this.atSign,
    required this.onNext,
    required this.onCancel,
  }) : super(key: key);

  @override
  _DesktopNotificationInfoPopUpState createState() =>
      _DesktopNotificationInfoPopUpState();
}

class _DesktopNotificationInfoPopUpState
    extends State<DesktopNotificationInfoPopUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 220,
      color: appTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ListView.separated(
                itemCount: 2,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.transparent,
                    height: 0.5,
                  );
                },
                itemBuilder: (context, i) {
                  return DesktopNotificationItem(
                    mainContext: context,
                    backgroundColor: appTheme.primaryLighterColor,
                  );
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    widget.onCancel();
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.desktop_see_update,
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onNext();
                      },
                      child: Text(
                        Strings.desktop_next,
                        style: TextStyle(
                          color: appTheme.primaryColor,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
