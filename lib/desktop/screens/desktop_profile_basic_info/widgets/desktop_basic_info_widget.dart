import 'dart:typed_data';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopBasicInfoWidget extends StatelessWidget {
  final BasicData data;
  final bool isCustomField;
  final bool showMenu;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const DesktopBasicInfoWidget({
    Key? key,
    required this.data,
    required this.isCustomField,
    required this.showMenu,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isPrivate) {
      return Container();
    }

    if (data.type == CustomContentType.Youtube.name ||
        data.type == CustomContentType.Link.name) {
      return _youtubeContent(context);
    } else if (data.type == CustomContentType.Image.name) {
      return _imageContent(context);
    } else if (data.type == CustomContentType.Html.name) {
      return _htmlContent(context);
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
              getTitle(data.displayingAccountName ?? ''),
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
              getTitle(data.displayingAccountName ?? ''),
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
          SizedBox(width: DesktopDimens.paddingNormal),
          Container(
            width: 150,
            child: Text(
              getTitle(data.displayingAccountName ?? ''),
              style:
                  TextStyle(color: appTheme.secondaryTextColor, fontSize: 16),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: DesktopDimens.paddingSmall),
                child: Container(
                  alignment: Alignment.centerLeft,
                  constraints: BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200,
                  ),
                  child: (data.value is Uint8List)
                      ? Image.memory(
                          data.value,
                          fit: BoxFit.contain,
                        )
                      : Container(),
                ),
              ),
            ),
          ),
          _buildMenuWidget(context),
        ],
      ),
    );
  }

  Widget _htmlContent(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      child: Row(
        children: [
          SizedBox(width: DesktopDimens.paddingNormal),
          Container(
            width: 150,
            child: Text(
              getTitle(data.displayingAccountName ?? ''),
              style:
                  TextStyle(color: appTheme.secondaryTextColor, fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(DesktopDimens.paddingSmall),
              child: HtmlWidget(data.value),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.primaryTextColor, width: 1),
              ),
            ),
          ),
          _buildMenuWidget(context),
        ],
      ),
    );
  }

  Widget _buildMenuWidget(BuildContext context) {
    if (!showMenu) {
      return SizedBox();
    }
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
              style: appTheme.textTheme.bodyText2,
            ),
          ),
          value: 0,
        ),
        PopupMenuItem(
          child: SizedBox(
            child: Text(
              "Delete",
              style: appTheme.textTheme.bodyText2,
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
