import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../desktop_follow_item.dart';
import 'desktop_follower_model.dart';

class DesktopFollowerPage extends StatefulWidget {
  const DesktopFollowerPage({Key? key}) : super(key: key);

  @override
  _DesktopFollowerPageState createState() => _DesktopFollowerPageState();
}

class _DesktopFollowerPageState extends State<DesktopFollowerPage>
    with AutomaticKeepAliveClientMixin<DesktopFollowerPage> {
  @override
  bool get wantKeepAlive => true;

  late DesktopFollowerModel _model;

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
        _model = DesktopFollowerModel(userPreview: userPreview);
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
              hint: Strings.desktop_search_follower,
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
              height: 16,
            ),
            Expanded(
              child: Consumer<DesktopFollowerModel>(
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
