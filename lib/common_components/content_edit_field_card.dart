import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class ContentEditFieldCard extends StatefulWidget {
  final String title, subtitle;
  final bool isPublic;
  ContentEditFieldCard(
      {required this.title, required this.subtitle, this.isPublic = true});
  @override
  _ContentEditFieldCardState createState() => _ContentEditFieldCardState();
}

class _ContentEditFieldCardState extends State<ContentEditFieldCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.lightText(
                    ColorConstants.greyText,
                    size: 16,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyles.lightText(ColorConstants.black, size: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        widget.isPublic ? Icon(Icons.public) : Icon(Icons.lock)
      ],
    );
  }
}
