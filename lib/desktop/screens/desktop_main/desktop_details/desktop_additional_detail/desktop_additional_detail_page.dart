import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_additional_detail/desktop_additional_detail_model.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../desktop_basic_item.dart';
import '../../desktop_media_item.dart';

class DesktopAdditionalDetailPage extends StatefulWidget {
  DesktopAdditionalDetailPage({Key? key}) : super(key: key);

  var _desktopAdditionalDetailPageState = _DesktopAdditionalDetailPageState();

  @override
  _DesktopAdditionalDetailPageState createState() =>
      this._desktopAdditionalDetailPageState =
          new _DesktopAdditionalDetailPageState();

  Future addField() async {
    await _desktopAdditionalDetailPageState.addField();
  }
}

class _DesktopAdditionalDetailPageState
    extends State<DesktopAdditionalDetailPage>
    with AutomaticKeepAliveClientMixin<DesktopAdditionalDetailPage> {
  late DesktopAdditionalDetailModel _model;

  @override
  bool get wantKeepAlive => true;

  Future addField() async {
    _model.addField();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.ADDITIONAL_DETAILS_KEY,
      child: ChangeNotifierProvider(
        create: (BuildContext c) {
          final userPreview = Provider.of<UserPreview>(context);
          _model = DesktopAdditionalDetailModel(userPreview: userPreview);
          return _model;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.LIGHT_GREY,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Consumer<DesktopAdditionalDetailModel>(
                        builder: (_, model, child) {
                          return ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            itemCount: model.fields.length,
                            itemBuilder: (context, index) {
                              return (model.fields[index].extension != null)
                                  ? DesktopMediaItem(
                                      data: model.fields[index],
                                    )
                                  : DesktopBasicItem(
                                      data: model.fields[index],
                                      onValueChanged: (text) {
                                        _model.updateValues(index, text);
                                      },
                                    );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DesktopButton(
                  title: Strings.desktop_reorder,
                  height: 48,
                  backgroundColor: appTheme.backgroundColor,
                  borderColor: appTheme.primaryTextColor,
                  titleColor: appTheme.primaryTextColor,
                  onPressed: () async {
                    await showReOderFieldsPopUp(
                      context,
                      AtCategory.ADDITIONAL_DETAILS,
                      () {
                        /// Update Fields after reorder
                        _model.fetchBasicData();
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
          ],
        ),
      ),
    );
  }
}
