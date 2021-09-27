import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:flutter/material.dart';

class DesktopEditMainPopUp extends StatefulWidget {
  Function() clickReorder;
  Function() clickAddCustomContent;
  Function() clickDelete;

  DesktopEditMainPopUp({
    Key? key,
    required this.clickReorder,
    required this.clickAddCustomContent,
    required this.clickDelete,
  }) : super(key: key);

  @override
  _DesktopEditMainPopUpState createState() => _DesktopEditMainPopUpState();
}

class _DesktopEditMainPopUpState extends State<DesktopEditMainPopUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 180,
      color: appTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem(Strings.desktop_reorder, appTheme, widget.clickReorder),
          _buildItem(Strings.desktop_add_custom_content, appTheme,
              widget.clickAddCustomContent),
          _buildItem(Strings.desktop_delete, appTheme, widget.clickDelete),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _buildItem(String text, AppTheme appTheme, Function() onClick) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: GestureDetector(
        onTap: onClick,
        child: Text(
          text,
          style: TextStyle(
            color: appTheme.primaryTextColor,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
