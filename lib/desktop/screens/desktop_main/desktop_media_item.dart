import 'dart:io';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_video_thumbnail_widget.dart';
import 'package:flutter/cupertino.dart';

class DesktopMediaItem extends StatelessWidget {
  String title;
  String path;
  String type;

  DesktopMediaItem({
    required this.title,
    required this.path,
    required this.type,
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
            child: (type == 'jpg' || type == 'png')
                ? Image.file(
                    File(path),
                    fit: BoxFit.fitWidth,
                  )
                : DesktopVideoThumbnailWidget(
                    path: path,
                    type: type ?? '',
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
