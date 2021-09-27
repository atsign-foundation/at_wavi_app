import 'dart:io';

import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_media/desktop_full_image_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_media/desktop_media_model.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_video_thumbnail_widget.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_full_video_page.dart';

class DesktopMediaPage extends StatefulWidget {
  DesktopMediaPage({Key? key}) : super(key: key);

  var _desktopMediaPageState = _DesktopMediaPageState();

  @override
  _DesktopMediaPageState createState() =>
      this._desktopMediaPageState = new _DesktopMediaPageState();

  Future addMedia(BasicData basicData) async {
    await _desktopMediaPageState.addMedia(basicData);
  }
}

class _DesktopMediaPageState extends State<DesktopMediaPage>
    with AutomaticKeepAliveClientMixin<DesktopMediaPage> {
  late DesktopMediaModel _model;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Future addMedia(BasicData basicData) async {
    _model.addMedia(basicData);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.MEDIA_KEY,
      child: ChangeNotifierProvider(
        create: (BuildContext c) {
          final userPreview = Provider.of<UserPreview>(context);
          _model = DesktopMediaModel(userPreview: userPreview);
          return _model;
        },
        child: Container(
          child: Consumer<DesktopMediaModel>(
            builder: (_, model, child) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      final result = await showDialog<BasicData>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: (model.fields[index].type == 'jpg' ||
                                  model.fields[index].type == 'png')
                              ? DesktopFullImagePage(
                                  path: model.fields[index].path!,
                                )
                              : DesktopFullVideoPage(
                                  path: model.fields[index].path!,
                                ),
                        ),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: [
                          (model.fields[index].type == 'jpg' ||
                                  model.fields[index].type == 'png')
                              ? Image.file(
                                  File(model.fields[index].path!),
                                  fit: BoxFit.fitWidth,
                                )
                              : DesktopVideoThumbnailWidget(
                                  path: model.fields[index].path!,
                                  type: model.fields[index].type ?? '',
                                ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                size: 24,
                                color: ColorConstants.DARK_GREY,
                              ),
                              onPressed: () {
                                _model.deleteMedia(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: model.fields.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
