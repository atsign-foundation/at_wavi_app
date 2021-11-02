import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopBasicInfoWidget extends StatelessWidget {
  final BasicData data;
  final bool isCustomField;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const DesktopBasicInfoWidget({
    Key? key,
    required this.data,
    required this.isCustomField,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.type == CustomContentType.Youtube.name) {
      return _youtubeContent(context);
    } else if (data.type == CustomContentType.Image.name) {
      return _imageContent(context);
    } else {
      return _textContent(context);
    }
  }

  Widget _textContent(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
      ),
      child: Row(
        children: [
          SizedBox(width: DesktopDimens.paddingNormal),
          Container(
            width: 150,
            child: Text(
              getTitle(data.accountName ?? ''),
              style: appTheme.textTheme.bodyText2?.copyWith(
                color: appTheme.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                data.value ?? '',
                style: appTheme.textTheme.bodyText2?.copyWith(
                  color: appTheme.primaryTextColor,
                ),
              ),
            ),
          ),
          _buildMenuWidget(context),
        ],
      ),
    );
  }

  Widget _youtubeContent(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
      ),
      child: Row(
        children: [
          SizedBox(width: DesktopDimens.paddingNormal),
          Container(
            width: 150,
            child: Text(
              getTitle(data.accountName ?? ''),
              style: appTheme.textTheme.bodyText2?.copyWith(
                color: appTheme.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                try {
                  await launch(data.value ?? '');
                } catch (e) {}
              },
              child: Container(
                child: Text(
                  data.value ?? '',
                  style: appTheme.textTheme.bodyText2?.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          _buildMenuWidget(context),
        ],
      ),
    );
  }

  Widget _imageContent(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      child: Row(
        children: [
          SizedBox(width: 27),
          Container(
            width: 200,
            child: Text(
              getTitle(data.accountName ?? ''),
              style:
                  TextStyle(color: appTheme.secondaryTextColor, fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 200,
              height: 200,
              child: Image.memory(
                data.value,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildMenuWidget(context),
        ],
      ),
    );
  }

  Widget _buildMenuWidget(BuildContext context) {
    if (!isCustomField) {
      return Container();
    }
    final appTheme = AppTheme.of(context);
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: SizedBox(
            child: Text(
              "Edit",
              style: appTheme.textTheme.bodyText1,
            ),
          ),
          value: 0,
        ),
        PopupMenuItem(
          child: SizedBox(
            child: Text(
              "Delete",
              style: appTheme.textTheme.bodyText1,
            ),
          ),
          value: 1,
        ),
      ],
      tooltip: null,
      child: SizedBox(
        width: 48,
        height: 52,
        child: Icon(
          Icons.more_vert_rounded,
          color: appTheme.secondaryTextColor,
        ),
      ),
      onSelected: (index) {
        if (index == 0) {
          onEditPressed?.call();
        } else if (index == 1) {
          onDeletePressed?.call();
        }
      },
    );
  }
}
