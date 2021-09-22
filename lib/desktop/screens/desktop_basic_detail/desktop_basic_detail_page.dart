import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/widgets/desktop_basic_detail_item_widget.dart';
import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/widgets/desktop_empty_category_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_label_button.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_preview_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_welcome_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_add_basic_detail/desktop_add_basic_detail_page.dart';
import 'desktop_basic_detail_model.dart';
import 'desktop_edit_basic_detail/desktop_edit_basic_detail_page.dart';
import 'desktop_reorder_basic_detail/desktop_reorder_basic_detail_page.dart';

class DesktopBasicDetailPage extends StatefulWidget {
  final AtCategory atCategory;

  const DesktopBasicDetailPage({
    Key? key,
    required this.atCategory,
  }) : super(key: key);

  @override
  _DesktopBasicDetailPageState createState() => _DesktopBasicDetailPageState();
}

class _DesktopBasicDetailPageState extends State<DesktopBasicDetailPage>
    with AutomaticKeepAliveClientMixin {

  late DesktopBasicDetailModel _model;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopBasicDetailModel(
          userPreview: userPreview,
          atCategory: widget.atCategory,
        );
        return _model;
      },
      child: Scaffold(
        body: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Consumer<DesktopBasicDetailModel>(
      builder: (_, model, child) {
        if (model.basicData.isEmpty) {
          return _buildEmptyWidget();
        } else {
          return _buildContentWidget(model.basicData);
        }
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Column(
      children: [
        SizedBox(height: 64),
        DesktopWelcomeWidget(),
        Expanded(
          child: Container(
            child: Center(
              child: DesktopEmptyCategoryWidget(
                atCategory: widget.atCategory,
                onAddDetailsPressed: _showEditDetailPopup,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentWidget(List<BasicData> data) {
    print('$data');
    final appTheme = AppTheme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 70, left: 80, right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  widget.atCategory.label,
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                DesktopIconLabelButton(
                  iconData: Icons.add_circle_outline_sharp,
                  label: 'Custom Content',
                  onPressed: _showAddCustomContent,
                ),
                DesktopPreviewButton(
                  onPressed: _showEditDetailPopup,
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = data[index];
                BorderRadius? borderRadius;
                if (data.length == 1) {
                  borderRadius = BorderRadius.all(Radius.circular(10));
                } else {
                  if (index == 0) {
                    borderRadius = BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    );
                  } else if (index == data.length) {
                    borderRadius = BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    );
                  }
                }
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xF5f5f5).withOpacity(0.5),
                    borderRadius: borderRadius,
                  ),
                  child: DesktopBasicDetailItemWidget(
                    title: item.accountName ?? '',
                    description: item.value ?? '',
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: appTheme.separatorColor,
                  indent: 27,
                  endIndent: 27,
                  height: 1,
                );
              },
              itemCount: data.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DesktopWhiteButton(
                  title: 'Reorder',
                  onPressed: _showReorderDetailPopup,
                ),
                SizedBox(width: 12),
                DesktopButton(
                  title: 'Save & Next',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDetailPopup() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopEditBasicDetailPage(
          atCategory: widget.atCategory,
        ),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showAddCustomContent() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopAddBasicDetailPage(),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showReorderDetailPopup() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopReorderBasicDetailPage(
          atCategory: widget.atCategory,
        ),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }
}
