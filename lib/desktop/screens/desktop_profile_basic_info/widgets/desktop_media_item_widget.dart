import 'dart:io';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_video_thumbnail_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/cupertino.dart';

class DesktopMediaItemWidget extends StatelessWidget {
  BasicData data;

  DesktopMediaItemWidget({
    required this.data,
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
          SizedBox(width: 11),
          Container(
            width: 200,
            child: Text(
              data.accountName ?? '',
              style: TextStyle(
                  fontSize: 16,
                  color: appTheme.secondaryTextColor,
                  fontFamily: 'Inter'),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 200,
            height: 200,
            child: (data.extension == 'jpg' || data.extension == 'png')
                ? Image.file(
              File(data.value!),
              fit: BoxFit.fitWidth,
            )
                : DesktopVideoThumbnailWidget(
              path: data.value!,
              extension: data.extension ?? '',
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
