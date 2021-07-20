import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title, subtitle;
  CustomCard({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.lightPurple,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyles.lightPurpleText14,
            ),
            SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyles.purple16,
            ),
          ],
        ),
      ),
    );
  }
}
