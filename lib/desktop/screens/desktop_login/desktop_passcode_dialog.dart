import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/routes/desktop_routes.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/passcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DesktopPassCodeDialog extends StatefulWidget {
  final String atSign;

  DesktopPassCodeDialog({
    Key? key,
    required this.atSign,
  }) : super(key: key);

  @override
  _DesktopPassCodeDialogState createState() => _DesktopPassCodeDialogState();
}

class _DesktopPassCodeDialogState extends State<DesktopPassCodeDialog> {
  late TextEditingController passCodeTextEditingController;

  @override
  void initState() {
    passCodeTextEditingController = TextEditingController(
      text: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 680,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: appTheme.backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 48, bottom: 32),
                child: Center(
                  child: Text(
                    '${Strings.desktop_passcode_title} @${widget.atSign}',
                    style: TextStyle(
                      color: appTheme.primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 28,
                    color: appTheme.primaryTextColor,
                  ),
                ),
              ),
            ],
          ),
          PassCodeWidget(
            controller: passCodeTextEditingController,
            maxLength: 6,
            isSecured: false,
            textWarning: Strings.desktop_wrong_passcode,
            onDone: (text) async {
              //Todo: verify passcode
              Navigator.pop(context, 'success');
            },
          ),
          SizedBox(height: 40),
          Text(
            Strings.desktop_or,
            style: TextStyle(
              color: appTheme.secondaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 32),
          Text(
            Strings.desktop_passcode_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appTheme.primaryTextColor,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 56,
          ),
        ],
      ),
    );
  }
}
