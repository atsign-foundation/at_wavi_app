import 'package:at_wavi_app/desktop/screens/desktop_additional_detail_popup/desktop_additional_detail_popup.dart';
import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/widgets/desktop_basic_detail_item_widget.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_welcome_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/desktop_empty_additional_detail_widget.dart';

class DesktopAdditionalDetailPage extends StatefulWidget {
  const DesktopAdditionalDetailPage({Key? key}) : super(key: key);

  @override
  _DesktopAdditionalDetailPageState createState() => _DesktopAdditionalDetailPageState();
}

class _DesktopAdditionalDetailPageState extends State<DesktopAdditionalDetailPage>
    with AutomaticKeepAliveClientMixin {

  bool isHaveData = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: isHaveData ? _buildContentWidget() : _buildEmptyWidget(),
          ),
        ],
      ),
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
              child: DesktopEmptyAdditionalDetailWidget(
                onAddDetailsPressed: _showAddDetailPopup,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentWidget() {
    final appTheme = AppTheme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 80, left: 80, right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Additional Details',
              style: TextStyle(
                color: appTheme.primaryTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              color: Color(0xF5f5f5).withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DesktopBasicDetailItemWidget(
                  title: 'Preferred Pronoun',
                  description: 'He/Him',
                ),
                Divider(
                  color: appTheme.separatorColor,
                  indent: 27,
                  endIndent: 27,
                  height: 1,
                ),
                DesktopBasicDetailItemWidget(
                  title: 'About',
                  description: 'Designer at @ Company',
                ),
                Divider(
                  color: appTheme.separatorColor,
                  indent: 27,
                  endIndent: 27,
                  height: 1,
                ),
                DesktopBasicDetailItemWidget(
                  title: 'Quote',
                  description: 'Let us make our future now, and let us make our dreams tomorrow’s reality.',
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 64),
            child: DesktopWhiteButton(
              title: 'Reorder',
              onPressed: () {
                print('Reorder pressed');
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAddDetailPopup() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopAdditionalDetailPopup(),
      ),
    );
    setState(() {
      isHaveData = !isHaveData;
    });
  }
}
