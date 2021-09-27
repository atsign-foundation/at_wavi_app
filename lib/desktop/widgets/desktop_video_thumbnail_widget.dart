import 'dart:typed_data';

import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_media/desktop_full_video_page.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopVideoThumbnailWidget extends StatelessWidget {
  String path;
  String type;

  DesktopVideoThumbnailWidget({
    Key? key,
    required this.path,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        (type.isNotEmpty && type != 'jpg' && type != 'png')
            ? Center(
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_fill,
                    size: 30,
                    color: ColorConstants.DARK_GREY,
                  ),
                  onPressed: () async {
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
    );
  }
}
