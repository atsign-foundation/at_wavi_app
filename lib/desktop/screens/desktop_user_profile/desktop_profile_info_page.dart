import 'package:at_client/at_client.dart';
import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
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
                  (_currentUser.image.value != null) ?
                 Container(
                    width: 160,
                  height: 160,
                   child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(80.0),
                      child: Image.memory(
                        _currentUser.image.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                 ):
                Container(
                  width: 160,
                  height: 160,
                  child: Icon(
                    Icons.account_circle,
                    size: 160,
                  ),
                 
                ),
                SizedBox(
                  height: 8,
                ),
                // Text(
                //   _displayingName(
                //     firstName: _currentUser.firstname.value,
                //     lastName: _currentUser.lastname.value,
                //   ),
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: appTheme.primaryTextColor,
                //     fontWeight: FontWeight.w600,
                //   ),
                //   maxLines: 2,
                // ),
                _buildNameWidget(),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _currentUser.atsign,
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
                      Strings.desktop_followers, (SearchService().followers_count!= null)?SearchService().followers_count.toString():'${followsCount(isFollowers: true)}', appTheme),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: widget.onFollowingPressed,
                  child: _buildInteractiveItem(
                      Strings.desktop_following, (SearchService().following_count!= null)?SearchService().following_count.toString():'${followsCount()}', appTheme),
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

  Widget _buildNameWidget() {
    final appTheme = AppTheme.of(context);
    String name = '';
    if (!isMyProfile) {
      name = context.select<UserPreview, String>(
        // Here, we are only interested whether [item] is inside the cart.
        (userPreview) {
          return _displayingName(
            firstName: userPreview.user()?.firstname.value,
            lastName: userPreview.user()?.lastname.value,
          );
        },
      );
      // _currentUser = Provider.of<UserPreview>(context, listen: false).user()!;
    } else if (Provider.of<UserProvider>(context, listen: false).user != null) {
      name = context.select<UserProvider, String>(
        // Here, we are only interested whether [item] is inside the cart.
        (userPreview) {
          return _displayingName(
            firstName: userPreview.user?.firstname.value,
            lastName: userPreview.user?.lastname.value,
          );
        },
      );
      // _currentUser = Provider.of<UserProvider>(context, listen: false).user!;
    }
    return Text(
      name,
      style: TextStyle(
        fontSize: 24,
        color: appTheme.primaryTextColor,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
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

  String _displayingName({dynamic firstName, dynamic lastName}) {
    String _name = '';
    _name = _currentUser.firstname.value ?? '';
    if (_currentUser.lastname.value != null) {
      _name = '$_name ${_currentUser.lastname.value}';
    }

    if (_name.isEmpty) {
      _name = _currentUser.atsign.replaceFirst('@', '');
    }
    return _name;
  }

  void _openEditProfile() {
    final user = context.read<UserProvider>().user;
    Provider.of<UserPreview>(context, listen: false).setUser = user;
    Navigator.pushNamed(context, DesktopRoutes.DESKTOP_EDIT_PROFILE);
  }
    String followsCount({bool isFollowers: false}) {
    AtFollowsData atFollowsData;
    var followsProvider = Provider.of<FollowService>(
        NavService.navKey.currentContext!,
        listen: false);
    if (!followsProvider.isFollowersFetched && isFollowers) {
      return '0';
    }

    if (!followsProvider.isFollowingFetched && !isFollowers) {
      return '0';
    }

    if (isFollowers) {
      atFollowsData = followsProvider.followers;
    } else {
      atFollowsData = followsProvider.following;
    }

    int num = atFollowsData.list!.length;

    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }
}
