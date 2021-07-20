import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/at_common_flutter.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var atClientPrefernce;

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
  void initState() {
    _checkToOnboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(Images.persona_icon),
                      SizedBox(width: 5.toWidth),
                      Text('@persona', style: TextStyle(color: Colors.black))
                    ],
                  ),
                ),
                SizedBox(height: 35.toHeight),
                Image.asset(Images.welcome_screen_banner),
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
