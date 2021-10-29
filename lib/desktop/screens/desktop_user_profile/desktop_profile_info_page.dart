import 'package:at_client/at_client.dart';
import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_logo.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopProfileInfoPage extends StatefulWidget {
  final String? atSign;
  final VoidCallback? onFollowerPressed;
  final VoidCallback? onFollowingPressed;
  final bool isPreview;

  DesktopProfileInfoPage({
    Key? key,
    required this.atSign,
    required this.isPreview,
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
    isMyProfile = !widget.isPreview;
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
        children: [
          _buildHeader(),
          SizedBox(height: DesktopDimens.paddingLarge),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: DesktopDimens.paddingNormal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (_currentUser.image.value != null)
                      ? Container(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80.0),
                            child: Image.memory(
                              _currentUser.image.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 120,
                          height: 120,
                          child: Icon(
                            Icons.account_circle,
                            size: 120,
                          ),
                        ),
                  SizedBox(height: DesktopDimens.paddingNormal),
                  _buildNameWidget(),
                  SizedBox(height: DesktopDimens.paddingSmall),
                  Text(
                    _currentUser.atsign,
                    style: appTheme.textTheme.subtitle1?.copyWith(
                      color: appTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: DesktopDimens.paddingLarge),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.onFollowerPressed,
                    child: _buildInteractiveItem(
                        Strings.desktop_followers,
                        (SearchService().followers_count != null)
                            ? SearchService().followers_count.toString()
                            : '${followsCount(isFollowers: true)}',
                        appTheme),
                  ),
                  SizedBox(height: DesktopDimens.paddingSmall),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.onFollowingPressed,
                    child: _buildInteractiveItem(
                        Strings.desktop_following,
                        (SearchService().following_count != null)
                            ? SearchService().following_count.toString()
                            : '${followsCount()}',
                        appTheme),
                  ),
                  SizedBox(height: DesktopDimens.paddingLarge),
                  isMyProfile
                      ? Column(
                          children: [
                            DesktopButton(
                              width: double.infinity,
                              height: DesktopDimens.buttonHeight,
                              backgroundColor: Colors.transparent,
                              titleColor: appTheme.primaryColor,
                              borderColor: appTheme.primaryColor,
                              title: Strings.desktop_edit_profile,
                              onPressed: _openEditProfile,
                            ),
                            SizedBox(height: DesktopDimens.paddingNormal),
                            DesktopButton(
                              width: double.infinity,
                              height: DesktopDimens.buttonHeight,
                              title: Strings.desktop_share_profile,
                              backgroundColor: appTheme.primaryColor,
                              onPressed: () async {},
                            ),
                          ],
                        )
                      : DesktopButton(
                          width: double.infinity,
                          height: DesktopDimens.buttonHeight,
                          backgroundColor: appTheme.primaryColor,
                          title: Strings.desktop_follow,
                          onPressed: () async {},
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final appTheme = AppTheme.of(context);
    return isMyProfile
        ? Container(
            padding: EdgeInsets.only(top: DesktopDimens.paddingNormal),
            child: Center(child: DesktopLogo()),
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
      style: appTheme.textTheme.headline6?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
    );
  }

  _buildInteractiveItem(String title, String subTitle, AppTheme appTheme) {
    return Row(
      children: [
        Text(
          title,
          style: appTheme.textTheme.subtitle2?.copyWith(
            color: appTheme.secondaryTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(),
        Text(
          subTitle,
          style: appTheme.textTheme.subtitle1?.copyWith(
            color: appTheme.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
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
