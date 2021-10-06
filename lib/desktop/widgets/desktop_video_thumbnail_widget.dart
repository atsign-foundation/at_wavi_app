import 'dart:typed_data';

import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_details/desktop_media/desktop_full_video_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/material.dart';

class DesktopVideoThumbnailWidget extends StatelessWidget {
  String path;
  String extension;

  DesktopVideoThumbnailWidget({
    Key? key,
    required this.path,
    required this.extension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          FutureBuilder(
            future: getVideoThumbnail(path),
            builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(
                          maxHeight: 200.0,
                        ),
                        child: Image.memory(snapshot.data!),
                      ),
                    );
                  }
              }
            },
          ),
          (extension.isNotEmpty && extension != 'jpg' && extension != 'png')
              ? Center(
                  child: GestureDetector(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: appTheme.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 28,
                          color: appTheme.primaryColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      final result = await showDialog<BasicData>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: DesktopFullVideoPage(
                            path: path,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
