import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

import 'desktop_passcode_dialog.dart';

class DesktopLoginPage extends StatefulWidget {
  const DesktopLoginPage({Key? key}) : super(key: key);

  @override
  _DesktopLoginPageState createState() => _DesktopLoginPageState();
}

class _DesktopLoginPageState extends State<DesktopLoginPage> {
  late TextEditingController atSignTextEditingController;
  var atClientPrefernce;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    atSignTextEditingController = TextEditingController(
      text: '',
    );
    //  _checkToOnboard();
    super.initState();
  }

  void _checkToOnboard() async {
    String? currentatSign = await BackendService().getAtSign();
    await BackendService()
        .getAtClientPreference()
        .then((value) => atClientPrefernce = value)
        .catchError((e) => print(e));

    if (currentatSign != null && currentatSign != '') {
      await BackendService()
          .onboard(currentatSign, atClientPreference: atClientPrefernce);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 78),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Image.asset(
                appTheme.isDark ? Images.logoLight : Images.logoDark,
                width: 90,
                height: 34,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.desktop_all_links_in_one,
                    style: TextStyle(
                      fontSize: 60,
                      color: appTheme.primaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    Strings.desktop_create_persona,
                    style: TextStyle(
                      fontSize: 16,
                      color: appTheme.secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 68),
                  Text(
                    Strings.desktop_sign,
                    style: TextStyle(
                      fontSize: 24,
                      color: appTheme.primaryTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 540,
                    child: Form(
                      key: _formKey,
                      child: DesktopTextField(
                        controller: atSignTextEditingController,
                        hint: Strings.desktop_enter_sign,
                        backgroundColor: appTheme.secondaryBackgroundColor,
                        borderRadius: 10,
                        textSize: 24,
                        hasUnderlineBorder: false,
                        contentPadding: 26,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Please enter your @sign';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  DesktopButton(
                    width: 540,
                    backgroundColor: appTheme.primaryColor,
                    title: Strings.desktop_send,
                    borderRadius: 10,
                    height: 72,
                    onPressed: _showPassCodeDialog,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  GestureDetector(
                    onTap: () {
                      BackendService().onboard('');
                    },
                    child: Text(
                      Strings.desktop_get_sign,
                      style: TextStyle(
                        fontSize: 12,
                        color: appTheme.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(),
            _buildFooterWidget(),
          ],
        ),
      ),
    );
  }

  _buildFooterWidget() {
    final appTheme = AppTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Strings.desktop_wavi,
          style: TextStyle(
            fontSize: 16,
            color: appTheme.primaryTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4),
        Text(
          Strings.desktop_company_copyrights,
          style: TextStyle(
            fontSize: 12,
            color: appTheme.secondaryTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  void _showPassCodeDialog() async {
    if(_formKey.currentState?.validate() == false) {
      return;
    }
    final atSign = atSignTextEditingController.text;
    // if (atSign.trim().isEmpty) {
    //   DialogUtils.showError(
    //     context: context,
    //     message: 'You must enter your @sign'
    //   );
    //   return;
    // }
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: DesktopPassCodeDialog(
            atSign: atSign,
          ),
        );
      },
    );
    if (result == 'success') {
      Navigator.of(context).pushNamedAndRemoveUntil(
          DesktopRoutes.DESKTOP_MY_PROFILE, (Route<dynamic> route) => false);
    }
  }
}
