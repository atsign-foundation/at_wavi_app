import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/services/follow_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
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

  @override
  void initState() {
    _controller =
        TabController(length: 2, vsync: this, initialIndex: _tabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25),
            color: ColorConstants.white,
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
                    style: TextStyles.boldText(ColorConstants.white, size: 18),
                  ),
                  trailing: Icon(Icons.public),
                ),
                SizedBox(height: 35),
                TabBar(
                  onTap: (index) async {},
                  labelColor: ColorConstants.black,
                  indicatorWeight: 5.toHeight,
                  indicatorColor: ColorConstants.orange,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: ColorConstants.black.withOpacity(0.5),
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
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 6),
                    child: Image.asset(Images.atIcon),
                  ),
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
                        child: Consumer<FollowService>(
                            builder: (context, _provider, _) {
                          return Wrap(
                            children: List.generate(
                                _provider.following.list!.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomPersonHorizontalTile(
                                    title: 'User name',
                                    subTitle: _provider.following.list![index],
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
                          );
                        }),
                      ),
                      SingleChildScrollView(
                        child: Consumer<FollowService>(
                            builder: (context, _provider, _) {
                          return Wrap(
                            children: List.generate(
                                _provider.followers.list!.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomPersonHorizontalTile(
                                    title: 'User name',
                                    subTitle: _provider.followers.list![index],
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
                          );
                        }),
                      ),
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
