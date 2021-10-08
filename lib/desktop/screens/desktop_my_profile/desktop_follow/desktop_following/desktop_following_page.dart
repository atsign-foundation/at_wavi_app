import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../desktop_follow_item.dart';
import 'desktop_following_model.dart';

class DesktopFollowingPage extends StatefulWidget {
  const DesktopFollowingPage({Key? key}) : super(key: key);

  @override
  _DesktopFollowingPageState createState() => _DesktopFollowingPageState();
}

class _DesktopFollowingPageState extends State<DesktopFollowingPage>
    with AutomaticKeepAliveClientMixin<DesktopFollowingPage> {
  @override
  bool get wantKeepAlive => true;

  late DesktopFollowingModel _model;

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
        _model = DesktopFollowingModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        color: appTheme.backgroundColor,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              height: 16,
            ),
            Expanded(
              child: Consumer<DesktopFollowingModel>(
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
