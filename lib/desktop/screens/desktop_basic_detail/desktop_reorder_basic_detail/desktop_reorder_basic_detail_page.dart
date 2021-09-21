import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_reorder_basic_detail/widgets/desktop_reorderable_item_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_reorder_basic_detail_model.dart';

class DesktopReorderBasicDetailPage extends StatefulWidget {
  AtCategory atCategory;

  DesktopReorderBasicDetailPage({
    Key? key,
    required this.atCategory,
  }) : super(key: key);

  @override
  _DesktopReorderBasicDetailPageState createState() =>
      _DesktopReorderBasicDetailPageState();
}

class _DesktopReorderBasicDetailPageState
    extends State<DesktopReorderBasicDetailPage> {
  late DesktopReorderBasicDetailModel _model;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopReorderBasicDetailModel(
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
              'Reorder Content',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 16),
            _buildContentWidget(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DesktopButton(
                    title: 'Save New Order',
                    width: double.infinity,
                    backgroundColor: appTheme.primaryColor,
                    onPressed: _onSaveData,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DesktopWhiteButton(
                    title: 'Cancel',
                    width: double.infinity,
                    onPressed: _onSaveData,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Consumer<DesktopReorderBasicDetailModel>(
      builder: (_, model, child) {
        return ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: 360.0,
          ),
          child: ReorderableListView(
            onReorder: _model.reorder,
            children: model.fields.map((e) {
              return DesktopReorderableItemWidget(
                key: Key(e),
                title: e,
                margin: EdgeInsets.symmetric(vertical: 2),
              );
            }).toList(),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
          // shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          // itemBuilder: (c, index) {
          //   final data = model.basicData[index];
          //   return DesktopReorderableItemWidget(
          //       title: data.accountName ?? '');
          // },
          // separatorBuilder: (context, index) {
          //   return SizedBox(height: 4);
          // },
          // itemCount: model.basicData.length,
        );
      },
    );
  }

  void _onSaveData() {
    _model.saveData(context);
  }
}
