import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopSearchInfoPopUp extends StatefulWidget {
  String atSign;
  String icon;
  String description;
  final Function onNext;
  final Function onCancel;

  DesktopSearchInfoPopUp({
    Key? key,
    required this.atSign,
    required this.icon,
    required this.description,
    required this.onNext,
    required this.onCancel,
  }) : super(key: key);

  @override
  _DesktopSearchInfoPopUpState createState() => _DesktopSearchInfoPopUpState();
}

class _DesktopSearchInfoPopUpState extends State<DesktopSearchInfoPopUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 240,
      color: appTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: appTheme.primaryLighterColor,
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 32,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  color: appTheme.accentColor,
                  width: 80,
                  height: 80,
                ),
                IconButton(
                  onPressed: () {
                    widget.onCancel();
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onNext();
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: appTheme.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
