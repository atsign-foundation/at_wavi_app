import 'dart:typed_data';

import 'package:at_backupkey_flutter/widgets/backup_key_widget.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_follows_flutter/screens/qrscan.dart';
import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/common_components/switch_at_sign.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/change_privacy_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
// import 'package:at_wavi_app/services/size_config.dart' as SizeConfigWavi;
import 'package:at_wavi_app/utils/colors.dart' as WaviColors;
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:at_follows_flutter/services/size_config.dart';
import 'package:at_follows_flutter/utils/color_constants.dart';

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
    // for follows package
    ColorConstants.appColor = Color.fromARGB(255, 0, 183, 184);
    ColorConstants.darkTheme = false;
    //

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
    SizeConfig().init(context); // for follows package

    if (_themeData == null) {
      return CircularProgressIndicator();
    }

    return Container(
      color: _themeData!.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomPersonHorizontalTile(
                    title: widget.name ??
                        BackendService().atClientInstance.getCurrentAtSign(),
                    subTitle:
                        BackendService().atClientInstance.getCurrentAtSign(),
                    textColor: _themeData!.primaryColor,
                    image: widget.image?.toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Tooltip(
                        message: 'Backup your keys',
                        child: BackupKeyWidget(
                          atClientService: BackendService().atClientInstance,
                          atsign: AtClientManager.getInstance()
                              .atClient
                              .getCurrentAtSign()!,
                          isIcon: true,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.toHeight),
            Divider(height: 1),
            SizedBox(height: 15.toHeight),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QrScan()));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.qr_code_scanner, size: 25),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Scan QR Code',
                        style: TextStyles.lightText(_themeData!.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
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
                              color: WaviColors.ColorConstants.DARK_GREY,
                              fontSize: 16.toFont,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none),
                        )
                      : Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: WaviColors.ColorConstants.black,
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
              onTap: () {
                _deleteAtSign(
                    AtClientManager.getInstance().atClient.getCurrentAtSign()!);
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(Icons.delete),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Delete @sign',
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
                var atSignList = await KeychainUtil.getAtsignList();

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
      ),
    );
  }

  _deleteAtSign(String atsign) async {
    final _formKey = GlobalKey<FormState>();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Center(
              child: Text(
                'Delete @sign',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.1,
                    fontSize: 20.toFont,
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to delete all data associated with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.1,
                    color: Colors.grey[700],
                    fontSize: 15.toFont,
                  ),
                ),
                SizedBox(height: 20),
                Text('$atsign',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.toFont,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(
                  'Type the @sign above to proceed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    letterSpacing: 0.1,
                    fontSize: 12.toFont,
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.toFont),
                    validator: (value) {
                      if (value != atsign) {
                        return "The @sign doesn't match.";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: WaviColors.ColorConstants.DARK_GREY)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Caution: this action can't be undone",
                  style: TextStyle(
                    fontSize: 13.toFont,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await BackendService()
                              .deleteAtSignFromKeyChain(atsign);
                        }
                      },
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class SetPrivateState with ChangeNotifier {
  bool isLoading = false;

  setLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
