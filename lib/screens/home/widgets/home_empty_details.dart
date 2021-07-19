import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';

class HomeEmptyDetails extends StatefulWidget {
  @override
  _HomeEmptyDetailsState createState() => _HomeEmptyDetailsState();
}

class _HomeEmptyDetailsState extends State<HomeEmptyDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text('Edit your profile', style: TextStyles.black18bold),
            SizedBox(height: 10.toHeight),
            Text(
              '''
Edit your profile and add details to start 
sharing your profile with others.''',
              style: TextStyles.grey15,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.toHeight),
            Text('Add Details', style: TextStyles.orange18bold),
          ],
        ),
      ),
    );
  }
}
