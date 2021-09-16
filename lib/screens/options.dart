import 'dart:typed_data';

import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/common_components/switch_at_sign.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/change_privacy_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatefulWidget {
  final String? name;
  final Uint8List? image;

  Options({this.name, this.image});
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool _allPrivate = false;
  late User _user;
  ThemeData? _themeData;

  @override
  void initState() {
    getUser();
    _getThemeData();
    super.initState();
  }

  _getThemeData() async {
    _themeData =
        await Provider.of<ThemeProvider>(context, listen: false).getTheme();

    if (mounted) {
      setState(() {});
    }
  }

  getUser() async {
    _user = Provider.of<UserProvider>(context, listen: false).user!;
    if (mounted) {
      setState(() {
        _allPrivate = _user.allPrivate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      return CircularProgressIndicator();
    }

    return Container(
      color: _themeData!.scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          CustomPersonHorizontalTile(
            title:
                widget.name ?? BackendService().atClientInstance.currentAtSign,
            subTitle: BackendService().atClientInstance.currentAtSign,
            textColor: _themeData!.primaryColor,
            image: widget.image?.toList(),
          ),
          SizedBox(height: 15.toHeight),
          Divider(height: 1),
          SizedBox(height: 15.toHeight),
          Row(
            children: <Widget>[
              Icon(Icons.qr_code_scanner, size: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'My QR Code',
                    style: TextStyles.lightText(_themeData!.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.toHeight),
          Divider(height: 1),
          SizedBox(
            height: 40,
            width: SizeConfig().screenWidth,
            child: Row(
              children: <Widget>[
                Icon(Icons.lock, size: 25),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Private Account',
                      style: TextStyles.lightText(_themeData!.primaryColor),
                    ),
                  ),
                ),
                Provider.of<SetPrivateState>(context).isLoading
                    ? LoadingDialog().onlyText(
                        'Updating',
                        style: TextStyle(
                            color: ColorConstants.DARK_GREY,
                            fontSize: 16.toFont,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none),
                      )
                    : Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: ColorConstants.black,
                          value: _allPrivate,
                          onChanged: (value) async {
                            await ChangePrivacyService()
                                .setAllPrivate(value, _user);
                            getUser();
                          },
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 15.toHeight),
          Divider(height: 1),
          InkWell(
            onTap: () {
              SetupRoutes.push(context, Routes.TERMS_CONDITIONS_SCREEN);
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    Images.termsAndConditionConditions,
                    color: _themeData!.primaryColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyles.lightText(_themeData!.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.toHeight),
          Divider(height: 1),
          SizedBox(height: 15.toHeight),
          InkWell(
            onTap: () {
              SetupRoutes.push(context, Routes.FAQS);
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    Images.faqs,
                    color: _themeData!.primaryColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'FAQs',
                      style: TextStyles.lightText(_themeData!.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.toHeight),
          Divider(height: 1),
          SizedBox(height: 15.toHeight),
          InkWell(
            onTap: () async {
              String? atSign = await BackendService().getAtSign();

              var atSignList = await BackendService()
                  .atClientServiceInstance
                  .getAtsignList();
            
              await showModalBottomSheet(
                context: NavService.navKey.currentContext!,
                backgroundColor: Colors.transparent,
                builder: (context) => AtSignBottomSheet(
                  atSignList: atSignList ?? [],
                ),
              );
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    Images.logout,
                    color: _themeData!.primaryColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Switch @sign',
                      style: TextStyles.lightText(_themeData!.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SetPrivateState with ChangeNotifier {
  bool isLoading = false;

  setLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
