import 'dart:async';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_constants.dart';
import 'package:at_wavi_app/view_models/Internet_connectivity_checker.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var atClientPrefernce;
  late StreamSubscription<dynamic> _intentDataStreamSubscription;

  @override
  void initState() {
    _checkToOnboard();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<InternetConnectivityChecker>(context, listen: false)
          .checkConnectivity();
    });

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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.asset(Images.personaIcon),
                      SizedBox(width: 5.toWidth),
                      Text('atWavi',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.toFont,
                              fontFamily: 'PlayfairDisplay'))
                    ],
                  ),
                ),
                SizedBox(height: 10.toHeight),
                // Image.asset(Images.welcomeScreenBanner),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.splash_1,
                      width: 180.toWidth,
                      height: 300.toHeight,
                    ),
                    Image.asset(
                      Images.splash_2,
                      width: 180.toWidth,
                      height: 300.toHeight,
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Text('Say Hello with atWavi',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.toFont,
                        fontFamily: 'PlayfairDisplay')),
                SizedBox(height: 15),
                Text(
                  '''
Create your very own,
free personal microsite.''',
                  style: TextStyle(
                      color: ColorConstants.greyText, fontSize: 15.toFont),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                CustomButton(
                  onPressed: () {
                    setState(() {});
                    BackendService().onboard('');
                  },
                  buttonColor: ColorConstants.black,
                  buttonText: 'Create my microsite',
                  fontColor: ColorConstants.white,
                  width: SizeConfig().screenWidth * 0.8,
                  height: 65.toHeight,
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    _showResetDialog();
                  },
                  child: Text('Reset',
                      style: TextStyle(
                          fontSize: 15.toFont, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 50),
                Text('© 2022 The @ Company',
                    style: TextStyle(
                        color: ColorConstants.greyText, fontSize: 13.toFont)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showResetDialog() async {
    bool isSelectAtsign = false;
    bool? isSelectAll = false;
    var atsignsList = await KeychainUtil.getAtsignList();
    if (atsignsList == null) {
      atsignsList = [];
    }
    Map atsignMap = {};
    for (String atsign in atsignsList) {
      atsignMap[atsign] = false;
    }
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, stateSet) {
            return AlertDialog(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Strings.resetDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.8,
                    )
                  ],
                ),
                content: atsignsList!.isEmpty
                    ? Column(mainAxisSize: MainAxisSize.min, children: [
                        Text(Strings.noAtsignToReset,
                            style: TextStyle(fontSize: 15)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 15,
                                // color: AtTheme.themecolor,
                              ),
                            ),
                          ),
                        )
                      ])
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CheckboxListTile(
                              onChanged: (value) {
                                isSelectAll = value;
                                atsignMap
                                    .updateAll((key, value1) => value1 = value);
                                // atsignMap[atsign] = value;
                                stateSet(() {});
                              },
                              value: isSelectAll,
                              checkColor: Colors.white,
                              title: Text('Select All',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            for (var atsign in atsignsList)
                              CheckboxListTile(
                                onChanged: (value) {
                                  atsignMap[atsign] = value;
                                  stateSet(() {});
                                },
                                value: atsignMap[atsign],
                                checkColor: Colors.white,
                                title: Text('$atsign'),
                              ),
                            Divider(thickness: 0.8),
                            if (isSelectAtsign)
                              Text(Strings.resetErrorText,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(Strings.resetWarningText,
                                style: TextStyle(fontSize: 14)),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              TextButton(
                                onPressed: () {
                                  var tempAtsignMap = {};
                                  tempAtsignMap.addAll(atsignMap);
                                  tempAtsignMap.removeWhere(
                                      (key, value) => value == false);
                                  if (tempAtsignMap.keys.toList().isEmpty) {
                                    isSelectAtsign = true;
                                    stateSet(() {});
                                  } else {
                                    isSelectAtsign = false;
                                    _resetDevice(tempAtsignMap.keys.toList());
                                  }
                                },
                                child: Text('Remove',
                                    style: TextStyle(
                                      color: ColorConstants.green,
                                      fontSize: 15,
                                    )),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)))
                            ])
                          ],
                        ),
                      ));
          });
        });
  }

  _resetDevice(List checkedAtsigns) async {
    Navigator.of(context).pop();
    await BackendService().resetAtsigns(checkedAtsigns).then((value) async {
      print('reset done');
    }).catchError((e) {
      print('error in reset: $e');
    });
  }
}
