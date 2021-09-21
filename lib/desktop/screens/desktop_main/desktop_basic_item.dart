import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class DesktopBasicItem extends StatelessWidget {
  String title;
  String value;

  DesktopBasicItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: appTheme.secondaryTextColor,
                  fontFamily: 'Inter'),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 14,
                  color: appTheme.primaryTextColor,
                  fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
    );
  }
}
