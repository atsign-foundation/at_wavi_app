import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class HomeFeatured extends StatefulWidget {
  @override
  _HomeFeaturedState createState() => _HomeFeaturedState();
}

class _HomeFeaturedState extends State<HomeFeatured> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Instagram',
                style: TextStyles.purple18bold,
              ),
              Text(
                'See more',
                style: TextStyles.purple16,
              ),
            ],
          ),
          SizedBox(height: 15.toHeight),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              runSpacing: 10.0,
              spacing: 20.0,
              children: List.generate(6, (index) {
                return Icon(
                  Icons.image,
                  size: 80,
                );
              }),
            ),
          ),
          SizedBox(height: 40.toHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Twitter',
                style: TextStyles.purple18bold,
              ),
              Text(
                'See more',
                style: TextStyles.purple16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
