import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/routes/desktop_routes.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:at_wavi_app/desktop/widgets/images/desktop_circle_avatar.dart';

class DesktopNotificationItem extends StatelessWidget {
  final NotificationItemType type;

  DesktopNotificationItem({
    this.type = NotificationItemType.Normal,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 400,
      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 4,
          ),
          Container(
            padding: EdgeInsets.only(top: 4),
            child: DesktopCircleAvatar(
              url:
                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
              size: 48,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@lauren changed her profile picture',
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '15 mins ago',
                  style: TextStyle(
                    color: appTheme.secondaryTextColor,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                type != NotificationItemType.Normal
                    ? GestureDetector(
                        onTap: () async {
                          DesktopSetupRoutes.push(
                            context,
                            DesktopRoutes.DESKTOP_USER_PROFILE,
                            arguments: {
                              'index': 1,
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFBE21),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              DesktopCircleAvatar(
                                url:
                                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                                size: 40,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lauren London',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '@lauren',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
}
