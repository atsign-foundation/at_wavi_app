import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:flutter/cupertino.dart';

class DesktopNewRequestItem extends StatelessWidget {
  Color backgroundColor;

  DesktopNewRequestItem({
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 4,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: appTheme.borderColor,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
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
                    fontSize: 10,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '15 mins ago',
                  style: TextStyle(
                    color: appTheme.secondaryTextColor,
                    fontSize: 11,
                    fontFamily: 'Inter',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          DesktopButton(
            width: 56,
            height: 32,
            textSize: 10,
            titleColor: appTheme.primaryTextColor,
            backgroundColor: appTheme.borderColor,
            borderColor: appTheme.separatorColor,
            title: Strings.desktop_delete,
            onPressed: () async {},
          ),
          SizedBox(
            width: 5,
          ),
          DesktopButton(
            width: 56,
            height: 32,
            textSize: 10,
            backgroundColor: appTheme.primaryColor,
            title: Strings.desktop_confirm,
            onPressed: () async {},
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
