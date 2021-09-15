import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopBasicDetailItemWidget extends StatelessWidget {
  final String title;
  final String description;

  const DesktopBasicDetailItemWidget({
    Key? key,
    this.title = '',
    this.description = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      height: 70,
      child: Row(
        children: [
          SizedBox(width: 27),
          Container(
            width: 200,
            child: Text(
              title,
              style: TextStyle(color: appTheme.secondaryTextColor, fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              width: 200,
              child: Text(
                description,
                style:
                    TextStyle(color: appTheme.primaryTextColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
