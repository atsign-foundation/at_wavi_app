import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopProfileInfoPage extends StatefulWidget {
  const DesktopProfileInfoPage({Key? key}) : super(key: key);

  @override
  _DesktopProfileInfoPageState createState() => _DesktopProfileInfoPageState();
}

class _DesktopProfileInfoPageState extends State<DesktopProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.desktopBackgroundLightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(24),
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.desktopGreen,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                  ),
                  // ClipRRect(
                  //   borderRadius:
                  //   BorderRadius.circular(90.0),
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     decoration: new BoxDecoration(
                  //       color: Colors.transparent,
                  //       borderRadius: new BorderRadius.all(
                  //           Radius.circular(90)),
                  //     ),
                  //     child: Image.network(
                  //       'https://i.picsum.photos/id/866/300/300.jpg?hmac=9qmLpcaT9TgKd6PD37aZJZ_7QvgrVFMcvI3JQKWVUIQ',
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Lauren London',
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '@laurenlondon',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorConstants.desktopGreen,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                _buildInteractiveItem('Followers', '120'),
                SizedBox(
                  height: 16,
                ),
                _buildInteractiveItem('Following', '121'),
                SizedBox(
                  height: 32,
                ),
                _buildFollowWidget(),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Container(
            height: 96,
          ),
        ],
      ),
    );
  }

  _buildInteractiveItem(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: ColorConstants.greyText,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 14,
            color: ColorConstants.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  _buildFollowWidget() {
    return Container(
      width: 270,
      child: ElevatedButton(
        onPressed: () async {
          await showPassCodeDialog(context, atSign: '@filmibiological');
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: ColorConstants.desktopGreen,
        ),
        child: Text('Follow'),
      ),
    );
  }
}
