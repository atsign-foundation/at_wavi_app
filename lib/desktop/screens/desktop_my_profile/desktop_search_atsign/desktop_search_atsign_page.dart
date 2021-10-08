import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_follow/desktop_follow_item.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_tabbar.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_search_atsign_model.dart';

class DesktopSearchAtSignPage extends StatefulWidget {
  const DesktopSearchAtSignPage({Key? key}) : super(key: key);

  @override
  _DesktopSearchAtSignPageState createState() =>
      _DesktopSearchAtSignPageState();
}

class _DesktopSearchAtSignPageState extends State<DesktopSearchAtSignPage> {
  late DesktopSearchAtSignModel _model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopSearchAtSignModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        color: appTheme.backgroundColor,
        width: 380,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 68),
            DesktopTextField(
              controller: TextEditingController(
                text: '',
              ),
              hint: Strings.desktop_search_sign,
              backgroundColor: appTheme.secondaryBackgroundColor,
              borderRadius: 10,
              hasUnderlineBorder: false,
              contentPadding: 0,
              onChanged: (text) {
                _model.searchUser(text);
              },
              prefixIcon: Container(
                width: 60,
                margin: EdgeInsets.only(left: 10, bottom: 1),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '@',
                          style: TextStyle(
                            color: appTheme.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'sign',
                          style: TextStyle(
                            color: appTheme.primaryTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              Strings.desktop_recent_search,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                color: appTheme.primaryTextColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: Consumer<DesktopSearchAtSignModel>(
                builder: (_, model, child) {
                  if (model.searchUsers.isEmpty) {
                    return Center(
                      child: DesktopEmptyWidget(
                        title: Strings.desktop_empty,
                        buttonTitle: '',
                        onButtonPressed: () {},
                        description: '',
                        image: Container(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.searchUsers.length,
                      itemBuilder: (context, index) {
                        return DesktopFollowItem(
                          title: model.searchUsers[index].atsign,
                          subTitle: '@${model.searchUsers[index].atsign}',
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
