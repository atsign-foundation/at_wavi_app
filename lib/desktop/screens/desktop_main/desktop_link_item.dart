import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class DesktopLinkItem extends StatelessWidget {
  String title;
  String name;
  String description;
  String follow;
  String link;

  DesktopLinkItem({
    required this.title,
    required this.name,
    required this.description,
    required this.follow,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: appTheme.secondaryTextColor,
                  fontFamily: 'Inter'),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 80,
            height: 80,
            child: Image.network(
              'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 14,
                      color: appTheme.primaryTextColor,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 12,
                      color: appTheme.secondaryTextColor,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  follow,
                  style: TextStyle(
                      fontSize: 14,
                      color: appTheme.primaryTextColor,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  link,
                  style: TextStyle(
                      fontSize: 12,
                      color: appTheme.primaryColor,
                      fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
