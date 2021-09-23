import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_social/desktop_social_model.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_link_item.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
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

class DesktopSocialAccountPage extends StatefulWidget {
  DesktopSocialAccountPage({Key? key}) : super(key: key);

  var _desktopSocialAccountPageState = _DesktopSocialAccountPageState();

  @override
  _DesktopSocialAccountPageState createState() =>
      this._desktopSocialAccountPageState =
          new _DesktopSocialAccountPageState();

  Future addField(BasicData basicData) async {
    await _desktopSocialAccountPageState.addField(basicData);
  }
}

class _DesktopSocialAccountPageState extends State<DesktopSocialAccountPage>
    with AutomaticKeepAliveClientMixin<DesktopSocialAccountPage> {
  late DesktopSocialModel _model;

  @override
  bool get wantKeepAlive => true;

  Future addField(BasicData basicData) async {
    _model.addField(basicData);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.SOCIAL_KEY,
      child: ChangeNotifierProvider(
        create: (BuildContext c) {
          final userPreview = Provider.of<UserPreview>(context);
          _model = DesktopSocialModel(userPreview: userPreview);
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
              child: Consumer<DesktopSocialModel>(
                builder: (_, model, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: model.fields.length,
                    itemBuilder: (context, index) {
                      return model.fields[index].accountName == 'Twitter'
                          ? DesktopBasicItem(
                              title: model.fields[index].accountName ?? '',
                              value: model.fields[index].valueDescription ?? '',
                            )
                          : DesktopLinkItem(
                              title: model.fields[index].accountName ?? '',
                              name: 'Lauren',
                              description: 'I tell story to entertain',
                              follow: '345 Followers, 645 Following',
                              link: 'www.facebook.com/lauren',
                            );
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
                              AtCategory.SOCIAL,
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
                          onPressed: () {},
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
