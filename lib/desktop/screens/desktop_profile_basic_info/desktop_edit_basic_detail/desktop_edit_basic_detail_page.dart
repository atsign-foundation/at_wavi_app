import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_private_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_edit_basic_detail_model.dart';

class DesktopEditBasicDetailPage extends StatefulWidget {
  final AtCategory atCategory;

  const DesktopEditBasicDetailPage({
    Key? key,
    required this.atCategory,
  }) : super(key: key);

  @override
  _DesktopEditBasicDetailState createState() => _DesktopEditBasicDetailState();
}

class _DesktopEditBasicDetailState extends State<DesktopEditBasicDetailPage> {
  final _showHideController = ShowHideController(isShow: null);
  late DesktopEditBasicDetailModel _model;

  @override
  void initState() {
    super.initState();
    final userPreview = Provider.of<UserPreview>(context, listen: false);
    _model = DesktopEditBasicDetailModel(
      userPreview: userPreview,
      atCategory: widget.atCategory,
    );
    if (_model.allFieldPrivate) {
      _showHideController.value = false;
    }
    if (_model.allFieldPublic) {
      _showHideController.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _model,
      child: Container(
        width: DesktopDimens.dialogWidth,
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: DesktopDimens.paddingNormal),
            Container(
              padding: EdgeInsets.only(left: DesktopDimens.paddingNormal),
              child: Text(
                widget.atCategory.label,
                style: appTheme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: appTheme.primaryTextColor,
                ),
              ),
            ),
            SizedBox(height: DesktopDimens.paddingNormal),
            _buildContentWidget(),
            SizedBox(height: DesktopDimens.paddingNormal),
            Container(
              padding: EdgeInsets.only(left: DesktopDimens.paddingNormal),
              child: DesktopShowHideRadioButton(
                controller: _showHideController,
                onChanged: (isPublic) {
                  if (isPublic) {
                    _model.saveAllFieldPublic();
                  } else {
                    _model.saveAllFieldPrivate();
                  }
                },
              ),
            ),
            SizedBox(height: DesktopDimens.paddingNormal),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: DesktopDimens.paddingNormal),
              child: DesktopButton(
                title: 'Done',
                width: double.infinity,
                onPressed: _onSaveData,
              ),
            ),
            SizedBox(height: DesktopDimens.paddingNormal),
          ],
        ),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Consumer<DesktopEditBasicDetailModel>(
      builder: (_, model, child) {
        return ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: 270.0,
          ),
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (c, index) {
                final data = model.basicData[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: DesktopDimens.paddingNormal),
                    Expanded(
                      child: DesktopTextField(
                        controller: data.controller ?? TextEditingController(),
                        title: data.data.displayingAccountName ?? '',
                      ),
                    ),
                    Container(
                      height: DesktopDimens.buttonHeight,
                      child: DesktopPublicButton(
                        controller: data.publicController,
                      ),
                    ),
                    SizedBox(width: DesktopDimens.paddingSmall),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: DesktopDimens.paddingNormal);
              },
              itemCount: model.basicData.length,
            ),
          ),
        );
      },
    );
  }

  void _onSaveData() {
    _model.saveData(context);
  }
}
