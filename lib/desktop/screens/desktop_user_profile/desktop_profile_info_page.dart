import 'package:at_client/at_client.dart';
import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopProfileInfoPage extends StatefulWidget {
  final String? atSign;
  final VoidCallback? onFollowerPressed;
  final VoidCallback? onFollowingPressed;

  DesktopProfileInfoPage({
    Key? key,
    required this.atSign,
    this.onFollowerPressed,
    this.onFollowingPressed,
  }) : super(key: key);

  @override
  _DesktopProfileInfoPageState createState() => _DesktopProfileInfoPageState();
}

class _DesktopProfileInfoPageState extends State<DesktopProfileInfoPage> {
  bool isMyProfile = true;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    if (!isMyProfile) {
      _currentUser = Provider.of<UserPreview>(context, listen: false).user()!;
    } else if (Provider.of<UserProvider>(context, listen: false).user != null) {
      _currentUser = Provider.of<UserProvider>(context, listen: false).user!;
    } else {
      _currentUser = User(
        atsign: AtClientManager.getInstance().atClient.getCurrentAtSign(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      color: appTheme.primaryLighterColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMyProfile
              ? Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: Image.asset(
                      appTheme.isDark ? Images.logoLight : Images.logoDark,
                      width: 90,
                      height: 34,
                    ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 160,
                  height: 160,
                  child: Icon(
                    Icons.account_circle,
                    size: 160,
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
                  _currentUser.firstname.value.toString() ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: appTheme.primaryTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _currentUser.atsign ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: appTheme.primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: widget.onFollowerPressed,
                  child: _buildInteractiveItem(
                      Strings.desktop_followers, '120', appTheme),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: widget.onFollowingPressed,
                  child: _buildInteractiveItem(
                      Strings.desktop_following, '121', appTheme),
                ),
                SizedBox(
                  height: 32,
                ),
                isMyProfile
                    ? Column(
                        children: [
                          DesktopButton(
                            width: 280,
                            height: 46,
                            backgroundColor: Colors.transparent,
                            titleColor: appTheme.primaryColor,
                            borderColor: appTheme.primaryColor,
                            title: Strings.desktop_edit_profile,
                            onPressed: _openEditProfile,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          DesktopButton(
                            width: 280,
                            height: 46,
                            title: Strings.desktop_share_profile,
                            backgroundColor: appTheme.primaryColor,
                            onPressed: () async {},
                          ),
                        ],
                      )
                    : DesktopButton(
                        width: 280,
                        height: 46,
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
      children: [
        SizedBox(width: 40),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: appTheme.secondaryTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 18,
            color: appTheme.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }

  void _openEditProfile() {
    Navigator.pushNamed(context, DesktopRoutes.DESKTOP_EDIT_PROFILE);
  }
}
