import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_follow/desktop_follow_item.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_search_model.dart';

class DesktopSearchPage extends StatefulWidget {
  const DesktopSearchPage({Key? key}) : super(key: key);

  @override
  _DesktopSearchPageState createState() => _DesktopSearchPageState();
}

class _DesktopSearchPageState extends State<DesktopSearchPage> {
  late DesktopSearchModel _model;

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
        _model = DesktopSearchModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        color: appTheme.backgroundColor,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            DesktopTextField(
              controller: TextEditingController(
                text: '',
              ),
              hint: Strings.desktop_search_sign,
              backgroundColor: ColorConstants.LIGHT_GREY,
              borderRadius: 10,
              textSize: 12,
              hasEnabledBorder: false,
              hasFocusBorder: false,
              onChanged: (text) {
                _model.searchUser(text);
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  Strings.desktop_prefix_sign,
                  style: TextStyle(
                    fontSize: 12,
                    color: appTheme.primaryTextColor,
                    fontFamily: 'Inter',
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
              child: Consumer<DesktopSearchModel>(
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
