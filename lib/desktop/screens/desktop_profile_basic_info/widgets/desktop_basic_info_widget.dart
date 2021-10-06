import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopBasicInfoWidget extends StatelessWidget {
  final BasicData data;

  const DesktopBasicInfoWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
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
          Expanded(
            child: Container(
              child: Text(
                data.value ?? '',
                style:
                    TextStyle(color: appTheme.primaryTextColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _youtubeContent(BuildContext context) {
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
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
