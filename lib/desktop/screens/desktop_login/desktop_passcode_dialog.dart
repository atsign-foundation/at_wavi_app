import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/routes/desktop_routes.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/passcode_widget.dart';
import 'package:flutter/material.dart';

class DesktopPassCodeDialog extends StatefulWidget {
  String atSign;

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
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  '${Strings.desktop_passcode_title} @${widget.atSign}',
                  style: TextStyle(
                    color: appTheme.primaryTextColor,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  size: 24,
                  color: appTheme.primaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          PassCodeWidget(
            controller: passCodeTextEditingController,
            maxLength: 6,
            isSecured: false,
            textWarning: Strings.desktop_wrong_passcode,
            onDone: (text) async {
              await Future.delayed(const Duration(milliseconds: 500));
              DesktopSetupRoutes.push(
                context,
                DesktopRoutes.DESKTOP_MAIN,
                arguments: {
                  'index': 1,
                },
              );
            },
          ),
          Text(
            Strings.desktop_or,
            style: TextStyle(
              color: appTheme.primaryTextColor,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            Strings.desktop_passcode_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appTheme.primaryTextColor,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
