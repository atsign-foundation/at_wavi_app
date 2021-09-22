import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../desktop_basic_item.dart';
import 'desktop_game_model.dart';

class DesktopGameAccountPage extends StatefulWidget {
  DesktopGameAccountPage({Key? key}) : super(key: key);

  _DesktopGameAccountPageState _desktopGameAccountPageState =
      _DesktopGameAccountPageState();

  @override
  _DesktopGameAccountPageState createState() => _desktopGameAccountPageState;

  Future updateFields() async {
    await _desktopGameAccountPageState.updateFields();
  }
}

class _DesktopGameAccountPageState extends State<DesktopGameAccountPage>
    with AutomaticKeepAliveClientMixin<DesktopGameAccountPage> {
  late DesktopGameModel _model;

  @override
  bool get wantKeepAlive => true;

  Future updateFields() async {
    await showReOderPopUp(
      context,
      (fields) {
        _model.updateField(fields);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopGameModel(userPreview: userPreview);
        return _model;
      },
      child: DesktopVisibilityDetectorWidget(
        keyScreen: AtCategory.GAMER.name,
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
                      return DesktopBasicItem(
                        title: getTitle(model.fields[index]),
                        value: '',
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

              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     DesktopBasicItem(
              //       title: Strings.desktop_ps4,
              //       value: 'ducpham',
              //     ),
              //     Container(
              //       height: 1,
              //       margin: EdgeInsets.symmetric(horizontal: 16),
              //       color: appTheme.borderColor,
              //     ),
              //     DesktopBasicItem(
              //       title: Strings.desktop_xbox,
              //       value: 'ducpham',
              //     ),
              //     Container(
              //       height: 1,
              //       margin: EdgeInsets.symmetric(horizontal: 16),
              //       color: appTheme.borderColor,
              //     ),
              //     DesktopBasicItem(
              //       title: Strings.desktop_twitch,
              //       value: 'twitch.tv/ducpham',
              //     ),
              //   ],
              // ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  String getTitle(String field) {
    switch (field) {
      case 'ps4':
        return Strings.desktop_ps4;
      case 'xbox':
        return Strings.desktop_xbox;
      case 'twitch':
        return Strings.desktop_twitch;
      default:
        return '';
    }
  }
}
