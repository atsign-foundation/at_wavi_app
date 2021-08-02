import 'dart:typed_data';

import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
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
                              AtsignDetails? atsignDetail;
                              String? name;
                              Uint8List? image;
                              var i = FollowService()
                                  .following
                                  .atsignListDetails
                                  .indexWhere((element) =>
                                      element.atcontact.atSign ==
                                      _provider.following.list![index]!);
                              if (i > -1) {
                                atsignDetail = FollowService()
                                    .following
                                    .atsignListDetails[i];
                                if (atsignDetail.atcontact.tags != null &&
                                    atsignDetail.atcontact.tags!['name'] !=
                                        null) {
                                  name = atsignDetail.atcontact.tags!['name'];
                                }
                                if (atsignDetail.atcontact.tags != null &&
                                    atsignDetail.atcontact.tags!['image'] !=
                                        null) {
                                  List<int> intList = atsignDetail
                                      .atcontact.tags!['image']
                                      .cast<int>();
                                  image = Uint8List.fromList(intList);
                                }
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomPersonHorizontalTile(
                                  title: name != null ? name : null,
                                  subTitle: _provider.following.list![index],
                                  trailingWidget: InkWell(
                                    onTap: () async {
                                      await FollowService().unfollow(
                                          _provider.following.list![index]!,
                                          index);
                                    },
                                    child: _provider
                                            .following
                                            .atsignListDetails[index]
                                            .isUnfollowing
                                        ? CircularProgressIndicator()
                                        : Text(
                                            'Unfollow',
                                            style: TextStyles.lightText(
                                                ColorConstants.orange,
                                                size: 16),
                                          ),
                                  ),
                                  image: image,
                                ),
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
                              AtsignDetails? atsignDetail;
                              String? name;
                              Uint8List? image;
                              var i = FollowService()
                                  .followers
                                  .atsignListDetails
                                  .indexWhere((element) =>
                                      element.atcontact.atSign ==
                                      _provider.followers.list![index]!);
                              if (i > -1) {
                                atsignDetail = FollowService()
                                    .followers
                                    .atsignListDetails[i];
                                if (atsignDetail.atcontact.tags != null &&
                                    atsignDetail.atcontact.tags!['name'] !=
                                        null) {
                                  name = atsignDetail.atcontact.tags!['name'];
                                }
                                if (atsignDetail.atcontact.tags != null &&
                                    atsignDetail.atcontact.tags!['image'] !=
                                        null) {
                                  List<int> intList = atsignDetail
                                      .atcontact.tags!['image']
                                      .cast<int>();
                                  image = Uint8List.fromList(intList);
                                }
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomPersonHorizontalTile(
                                    title: name != null ? name : null,
                                    subTitle: _provider.followers.list![index],
                                    trailingWidget: InkWell(
                                      onTap: () async {
                                        FollowService().removeFollower(
                                            _provider.followers.list![index]!,
                                            index);
                                      },
                                      child: _provider
                                              .followers
                                              .atsignListDetails[index]
                                              .isRmovingFromFollowers
                                          ? CircularProgressIndicator()
                                          : Text(
                                              'Remove',
                                              style: TextStyles.lightText(
                                                  ColorConstants.orange,
                                                  size: 16),
                                            ),
                                    ),
                                    image: image),
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
