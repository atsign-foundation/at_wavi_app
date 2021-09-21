import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_reorder_basic_detail/desktop_reorder_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_additional_detail/desktop_additional_detail_model.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../desktop_basic_item.dart';

class DesktopAdditionalDetailPage extends StatefulWidget {
  DesktopAdditionalDetailPage({Key? key}) : super(key: key);

  _DesktopAdditionalDetailPageState _desktopAdditionalDetailPageState =
      _DesktopAdditionalDetailPageState();

  @override
  _DesktopAdditionalDetailPageState createState() =>
      _desktopAdditionalDetailPageState;

  Future updateFields() async {
    await _desktopAdditionalDetailPageState.updateFields();
  }
}

class _DesktopAdditionalDetailPageState
    extends State<DesktopAdditionalDetailPage>
    with AutomaticKeepAliveClientMixin<DesktopAdditionalDetailPage> {
  late DesktopAdditionalDetailModel _model;

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
        _model = DesktopAdditionalDetailModel(userPreview: userPreview);
        return _model;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorConstants.LIGHT_GREY,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Consumer<DesktopAdditionalDetailModel>(
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
            //       title: Strings.desktop_preferred_pronoun,
            //       value: 'He/Him',
            //     ),
            //     Container(
            //       height: 1,
            //       margin: EdgeInsets.symmetric(horizontal: 16),
            //       color: appTheme.borderColor,
            //     ),
            //     DesktopBasicItem(
            //       title: Strings.desktop_about,
            //       value: 'Design at @Company',
            //     ),
            //     Container(
            //       height: 1,
            //       margin: EdgeInsets.symmetric(horizontal: 16),
            //       color: appTheme.borderColor,
            //     ),
            //     DesktopBasicItem(
            //       title: Strings.desktop_quote,
            //       value: 'Let us make our future now.',
            //     ),
            //     Container(
            //       height: 1,
            //       margin: EdgeInsets.symmetric(horizontal: 16),
            //       color: appTheme.borderColor,
            //     ),
            //     DesktopBasicItem(
            //       title: Strings.desktop_video,
            //       value: '',
            //     ),
            //   ],
            // ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  String getTitle(String field) {
    switch (field) {
      case 'pronoun':
        return Strings.desktop_preferred_pronoun;
      case 'about':
        return Strings.desktop_about;
      case 'quote':
        return Strings.desktop_quote;
      case 'video':
        return Strings.desktop_video;
      default:
        return '';
    }
  }
}
