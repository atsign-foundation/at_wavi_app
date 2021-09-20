import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopProfileInfoPage extends StatefulWidget {
  late bool isMyProfile;

  DesktopProfileInfoPage({
    Key? key,
    this.isMyProfile = false,
  }) : super(key: key);

  @override
  _DesktopProfileInfoPageState createState() => _DesktopProfileInfoPageState();
}

class _DesktopProfileInfoPageState extends State<DesktopProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      color: appTheme.primaryLighterColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isMyProfile
              ? Container(
                  margin: EdgeInsets.only(top: 32),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo_dark.png',
                    fit: BoxFit.fitHeight,
                    height: 32,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      Strings.desktop_back,
                      style: TextStyle(
                        fontSize: 14,
                        color: appTheme.primaryColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                  ),
                  // ClipRRect(
                  //   borderRadius:
                  //   BorderRadius.circular(90.0),
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     decoration: new BoxDecoration(
                  //       color: Colors.transparent,
                  //       borderRadius: new BorderRadius.all(
                  //           Radius.circular(90)),
                  //     ),
                  //     child: Image.network(
                  //       'https://i.picsum.photos/id/866/300/300.jpg?hmac=9qmLpcaT9TgKd6PD37aZJZ_7QvgrVFMcvI3JQKWVUIQ',
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Lauren London',
                  style: TextStyle(
                    fontSize: 20,
                    color: appTheme.primaryTextColor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '@laurenlondon',
                  style: TextStyle(
                    fontSize: 15,
                    color: appTheme.primaryColor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                _buildInteractiveItem(
                    Strings.desktop_followers, '120', appTheme),
                SizedBox(
                  height: 16,
                ),
                _buildInteractiveItem(
                    Strings.desktop_following, '121', appTheme),
                SizedBox(
                  height: 32,
                ),
                widget.isMyProfile
                    ? Column(
                        children: [
                          DesktopButton(
                            width: 280,
                            height: 40,
                            backgroundColor: ColorConstants.white,
                            titleColor: appTheme.primaryColor,
                            borderColor: appTheme.primaryColor,
                            title: Strings.desktop_edit_profile,
                            onPressed: () async {},
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          DesktopButton(
                            width: 280,
                            height: 40,
                            title: Strings.desktop_share_profile,
                            backgroundColor: appTheme.primaryColor,
                            onPressed: () async {},
                          ),
                        ],
                      )
                    : DesktopButton(
                        width: 280,
                        height: 40,
                        backgroundColor: appTheme.primaryColor,
                        title: Strings.desktop_follow,
                        onPressed: () async {},
                      ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Container(
            height: 96,
          ),
        ],
      ),
    );
  }

  _buildInteractiveItem(String title, String subTitle, AppTheme appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: appTheme.secondaryTextColor,
            fontWeight: FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 14,
            color: appTheme.primaryTextColor,
            fontWeight: FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
