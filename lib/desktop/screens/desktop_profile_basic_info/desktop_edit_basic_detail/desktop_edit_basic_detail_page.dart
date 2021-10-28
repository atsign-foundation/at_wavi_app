import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
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
  final _showHideController = ShowHideController(isShow: true);
  late DesktopEditBasicDetailModel _model;

  @override
  void initState() {
    super.initState();
    final userPreview = Provider.of<UserPreview>(context, listen: false);
    _model = DesktopEditBasicDetailModel(
      userPreview: userPreview,
      atCategory: widget.atCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _model,
      child: Container(
        width: 434,
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                widget.atCategory.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: appTheme.primaryTextColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildContentWidget(),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(left: 24),
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
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: DesktopButton(
                title: 'Done',
                width: double.infinity,
                onPressed: _onSaveData,
              ),
            ),
            SizedBox(height: 24),
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
            maxHeight: 360.0,
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
                    SizedBox(width: 24),
                    Expanded(
                      child: DesktopTextField(
                        controller: data.controller ?? TextEditingController(),
                        title: data.data.accountName ?? '',
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: DesktopPublicButton(
                        controller: data.publicController,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
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
