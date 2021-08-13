import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class EmptyWidget extends StatefulWidget {
  final ThemeData themeData;
  EmptyWidget(this.themeData);

  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.note_outlined,
              size: 25,
              color: widget.themeData.primaryColor,
            ),
            SizedBox(height: 10.toHeight),
            Text('No Details',
                style: CustomTextStyles.customBoldTextStyle(
                    widget.themeData.primaryColor,
                    size: 18)),
            SizedBox(height: 10.toHeight),
            Text(
              "This user has not added any information.",
              style: TextStyles.grey15,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
