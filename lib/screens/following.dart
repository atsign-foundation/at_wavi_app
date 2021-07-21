import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Following extends StatefulWidget {
  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _tabIndex = 0;
  late bool _isDark;
  late ThemeData _themeData;

  @override
  void initState() {
    _controller =
        TabController(length: 2, vsync: this, initialIndex: _tabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    if (_isDark) {
      _themeData = Themes.darkTheme;
    } else {
      _themeData = Themes.lightTheme;
    }

    SizeConfig().init(context);
    return Container(
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25),
            color: _themeData.scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Header(
                  leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  centerWidget: Text(
                    '@lauren',
                    style: TextStyles.boldText(
                        _isDark ? ColorConstants.white : ColorConstants.black,
                        size: 18),
                  ),
                  trailing: Icon(Icons.public),
                ),
                SizedBox(height: 35),
                TabBar(
                  onTap: (index) async {},
                  labelColor:
                      _isDark ? ColorConstants.white : ColorConstants.black,
                  indicatorWeight: 5.toHeight,
                  indicatorColor: ColorConstants.orange,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: _isDark
                      ? ColorConstants.white.withOpacity(0.5)
                      : ColorConstants.black.withOpacity(0.5),
                  controller: _controller,
                  tabs: [
                    Text(
                      'Following',
                      style: TextStyle(letterSpacing: 0.1, fontSize: 18),
                    ),
                    Text(
                      'Followers',
                      style: TextStyle(letterSpacing: 0.1, fontSize: 18),
                    )
                  ],
                ),
                Divider(height: 1),
                SizedBox(height: 25),
                CustomInputField(
                  width: 343.toWidth,
                  height: 60.toHeight,
                  hintText: '',
                  leadingWidget: Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 6),
                    child: Image.asset(Images.atIcon),
                  ),
                  inputFieldColor: _isDark ? ColorConstants.greyText : null,
                  value: (String s) {
                    print('text : $s');
                  },
                ),
                SizedBox(height: 25.toHeight),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(40, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomPersonHorizontalTile(
                                  title: 'User name',
                                  subTitle: '@atsign',
                                  trailingWidget: InkWell(
                                    child: Text(
                                      'Unfollow',
                                      style: TextStyles.lightText(
                                          ColorConstants.orange,
                                          size: 16),
                                    ),
                                  )),
                            );
                          }),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(40, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomPersonHorizontalTile(
                                  title: 'User name',
                                  subTitle: '@atsign',
                                  trailingWidget: InkWell(
                                    child: Text(
                                      'Remove',
                                      style: TextStyles.lightText(
                                          ColorConstants.orange,
                                          size: 16),
                                    ),
                                  )),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
