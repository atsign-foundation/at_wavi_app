import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopFollowItem extends StatefulWidget {
  String title;
  String subTitle;

  DesktopFollowItem({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  _DesktopFollowItemState createState() => _DesktopFollowItemState();
}

class _DesktopFollowItemState extends State<DesktopFollowItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: appTheme.borderColor,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 10,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.subTitle,
                  style: TextStyle(
                    color: appTheme.secondaryTextColor,
                    fontSize: 11,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
}
