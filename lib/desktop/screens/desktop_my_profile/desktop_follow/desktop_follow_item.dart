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
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(
              'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw',
              fit: BoxFit.fitWidth,
              width: 60,
              height: 60,
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
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.subTitle,
                  style: TextStyle(
                    color: appTheme.secondaryTextColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              child: Center(
                child: Text(
                  'Unfollow',
                  style: TextStyle(
                    color: appTheme.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
