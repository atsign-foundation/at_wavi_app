import 'dart:async';

import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

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
    _receiveIntent();
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

  _receiveIntent() async {
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      print("Incoming Shared file in home :" +
          (value.map((f) => f.path).join(",")));

      if (value != null) {}
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      print('Incoming images Value in home  is $value');
      if (value != null) {}
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      print('Incoming text Value in home  is $value');
      if (value != null) {
        SetupRoutes.push(NavService.navKey.currentContext!, Routes.ADD_LINK,
            arguments: {'url': value});
      }
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) {
        SetupRoutes.push(NavService.navKey.currentContext!, Routes.ADD_LINK,
            arguments: {'url': value});
      }
      print('Incoming text in home  when app is closed $value');
    });
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
                  padding: EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.asset(Images.personaIcon),
                      SizedBox(width: 5.toWidth),
                      Text('@wavi.ng',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.toFont,
                              fontFamily: 'PlayfairDisplay'))
                    ],
                  ),
                ),
                SizedBox(height: 35.toHeight),
                Image.asset(Images.welcomeScreenBanner),
                SizedBox(height: 35),
                Text('All links in one!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 38.toFont,
                        fontFamily: 'PlayfairDisplay')),
                SizedBox(height: 15),
                Text(
                  '''
Create your persona in a single link
and share it with others.''',
                  style: TextStyle(
                      color: ColorConstants.greyText, fontSize: 15.toFont),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                CustomButton(
                  onPressed: () {
                    setState(() {});
                    BackendService().onboard('');
                  },
                  buttonColor: ColorConstants.black,
                  buttonText: 'Create my persona',
                  fontColor: ColorConstants.white,
                  width: 212.toWidth,
                  height: 65.toHeight,
                ),
                SizedBox(height: 50),
                Text('The @ Company Copyright 2020',
                    style: TextStyle(
                        color: ColorConstants.greyText, fontSize: 13.toFont)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
