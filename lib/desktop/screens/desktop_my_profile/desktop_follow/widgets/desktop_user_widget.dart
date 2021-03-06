import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_avatar_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopUserWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onPressed;
  final VoidCallback? onFollowPressed;

  DesktopUserWidget({
    Key? key,
    required this.user,
    this.onPressed,
    this.onFollowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    bool isFollowingThisAtSign =
        Provider.of<FollowService>(context, listen: false)
            .isFollowing(user.atsign);
    bool isMine = toAccountNameWithAtsign(user.atsign) ==
        toAccountNameWithAtsign(
            Provider.of<UserProvider>(context, listen: false).user?.atsign);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DesktopAvatarWidget(
              atSign: user.atsign,
              imageData: user.image.value,
            ),
            SizedBox(width: DesktopDimens.paddingSmall),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayingName(
                      firstname: user.firstname,
                      lastname: user.lastname,
                    ),
                    style: appTheme.textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '@' + user.atsign,
                    style: appTheme.textTheme.subtitle2
                        ?.copyWith(color: appTheme.secondaryTextColor),
                  ),
                ],
              ),
            ),
            if (!isMine)
              GestureDetector(
                onTap: onFollowPressed,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  child: Center(
                    child: Text(
                      isFollowingThisAtSign ? 'Unfollow' : 'Follow1',
                      style: appTheme.textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _displayingName({dynamic firstname, dynamic lastname}) {
    String _name = '';
    _name = firstname?.value ?? '';
    if (lastname?.value != null) {
      _name = '$_name ${lastname.value}';
    }

    return _name;
  }
}
