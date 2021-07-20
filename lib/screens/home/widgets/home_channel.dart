import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class HomeChannels extends StatefulWidget {
  @override
  _HomeChannelsState createState() => _HomeChannelsState();
}

class _HomeChannelsState extends State<HomeChannels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '@apps',
            style: TextStyles.purple18bold,
          ),
          SizedBox(height: 15.toHeight),
          SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15),
                color: ColorConstants.lightPurple,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.app_blocking, size: 35),
                    Icon(Icons.app_blocking, size: 35),
                  ],
                ),
              )),
          SizedBox(height: 40.toHeight),
          Text(
            'Social Accounts',
            style: TextStyles.purple18bold,
          ),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Facebook',
                subtitle: 'fb.com/laurenlondon',
              )),
          Divider(height: 1),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Twitter',
                subtitle: 'twitter.com/laurenlondon',
              )),
          SizedBox(height: 40.toHeight),
          Text(
            'Game Accounts',
            style: TextStyles.purple18bold,
          ),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'PS4',
                subtitle: 'tackojohnlauren',
              )),
          Divider(height: 1),
          SizedBox(
              width: double.infinity,
              child: CustomCard(
                title: 'Xbox',
                subtitle: 'tackolauren',
              )),
        ],
      ),
    );
  }
}
