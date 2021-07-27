import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/common_components/switch_at_sign.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CustomPersonHorizontalTile(
            title: 'Lauren London',
            subTitle: '@lauren',
          ),
          SizedBox(height: 15),
          Divider(height: 1),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Icon(Icons.qr_code_scanner, size: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('My QR Code'),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(height: 1),
          Row(
            children: <Widget>[
              Icon(Icons.lock, size: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Private Account'),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: ColorConstants.black,
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(height: 1),
          Row(
            children: <Widget>[
              Icon(Icons.remove_red_eye_rounded, size: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Searchable Account'),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: ColorConstants.black,
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          // Divider(height: 1),
          // Row(
          //   children: <Widget>[
          //     Icon(Icons.notifications_active, size: 25),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 8.0),
          //         child: Text('Receive other notifications'),
          //       ),
          //     ),
          //     Transform.scale(
          //       scale: 0.7,
          //       child: CupertinoSwitch(
          //         activeColor: ColorConstants.black,
          //         value: true,
          //         onChanged: (value) {},
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15),
          Divider(height: 1),
          Row(
            children: <Widget>[
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset(Images.termsAndConditionConditions),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Terms and Conditions'),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(height: 1),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset(Images.faqs),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('FAQs'),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(height: 1),
          SizedBox(height: 15),
          InkWell(
            onTap: () async {
              String? atSign = await BackendService().getAtSign();

              var atSignList = await BackendService()
                  .atClientServiceMap[atSign]!
                  .getAtsignList();
              await showModalBottomSheet(
                context: NavService.navKey.currentContext!,
                backgroundColor: Colors.transparent,
                builder: (context) => AtSignBottomSheet(
                  atSignList: atSignList!,
                ),
              );
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(Images.logout),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Switch @sign'),
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
