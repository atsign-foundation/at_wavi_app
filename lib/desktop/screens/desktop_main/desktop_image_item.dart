import 'dart:io';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class DesktopImageItem extends StatelessWidget {
  String title;
  String path;

  DesktopImageItem({
    required this.title,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 110,
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
          Container(
            width: 88,
            height: 88,
            child: Image.file(
              File(path),
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
