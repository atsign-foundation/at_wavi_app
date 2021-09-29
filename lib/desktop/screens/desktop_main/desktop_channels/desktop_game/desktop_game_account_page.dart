import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../desktop_basic_item.dart';
import '../../desktop_media_item.dart';
import 'desktop_game_model.dart';

class DesktopGameAccountPage extends StatefulWidget {
  DesktopGameAccountPage({Key? key}) : super(key: key);

  var _desktopGameAccountPageState = _DesktopGameAccountPageState();

  @override
  _DesktopGameAccountPageState createState() =>
      this._desktopGameAccountPageState = new _DesktopGameAccountPageState();

  Future addField() async {
    await _desktopGameAccountPageState.addField();
  }
}

class _DesktopGameAccountPageState extends State<DesktopGameAccountPage>
    with AutomaticKeepAliveClientMixin<DesktopGameAccountPage> {
  late DesktopGameModel _model;

  @override
  bool get wantKeepAlive => true;

  Future addField() async {
    _model.addField();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.GAME_KEY,
      child: ChangeNotifierProvider(
        create: (BuildContext c) {
          final userPreview = Provider.of<UserPreview>(context);
          _model = DesktopGameModel(userPreview: userPreview);
          return _model;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.LIGHT_GREY,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Consumer<DesktopGameModel>(
                builder: (_, model, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: model.fields.length,
                    itemBuilder: (context, index) {
                      if (model.fields[index].extension != null) {
                        return DesktopMediaItem(
                          data: model.fields[index],
                        );
                      } else {
                        return DesktopBasicItem(
                          data: model.fields[index],
                          onValueChanged: (text) {
                            _model.updateValues(index, text);
                          },
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          height: 1,
                          color: appTheme.borderColor,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DesktopWhiteButton(
                          title: Strings.desktop_reorder,
                          height: 48,
                          onPressed: () async {
                            await showReOderFieldsPopUp(
                              context,
                              AtCategory.GAMER,
                              (fields) {
                                /// Update Fields after reorder
                                _model.reorderField(fields);
                              },
                            );
                          },
                        ),
                        SizedBox(width: 12),
                        DesktopButton(
                          title: Strings.desktop_save_publish,
                          height: 48,
                          onPressed: () async {
                            await _model.saveAndPublish();
                            showSnackBar(context, Strings.desktop_edit_success,
                                appTheme.primaryColor);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
