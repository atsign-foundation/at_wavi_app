import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/model/user.dart';
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
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopEditBasicDetailModel(
          userPreview: userPreview,
          atCategory: widget.atCategory,
        );
        return _model;
      },
      child: Container(
        width: 434,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.atCategory.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 16),
            _buildContentWidget(),
            SizedBox(height: 16),
            DesktopShowHideRadioButton(
              controller: _showHideController,
            ),
            SizedBox(height: 16),
            DesktopButton(
              title: 'Done',
              width: double.infinity,
              onPressed: _onSaveData,
            )
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
                return DesktopTextField(
                  controller: data.controller ?? TextEditingController(),
                  title: data.data.accountName ?? '',
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
