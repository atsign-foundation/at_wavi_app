import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopWelcomeWidget extends StatelessWidget {
  const DesktopWelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: appTheme.primaryTextColor,
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.only(bottom: 7),
                child: Image.asset(
                  appTheme.isDark ? Images.logoLight : Images.logoDark,
                  width: 110,
                  height: 40,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Please fill-in the necessary details to start using.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: appTheme.secondaryTextColor,
            ),
          )
        ],
      ),
    );
  }
}
