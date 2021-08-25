import 'dart:typed_data';

import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
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
  String _searchedText = '';

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
                  centerWidgetFlex: 4,
                  leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  centerWidget: Text(
                    BackendService().atClientInstance.currentAtSign!,
                    style: TextStyles.boldText(ColorConstants.black, size: 18),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
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
                  initialValue: _searchedText,
                  value: (String s) {
                    setState(() {
                      _searchedText = s;
                    });
                    print('s $s');
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
                          print('Consumer<FollowService> built');
                          // var _providerList = _provider.following.list ?? [];
                          List<String?> _filteredList =
                              _provider.following.list ?? [];
                          // if (_searchedText.isNotEmpty) {
                          //   _filteredList = _providerList
                          //       .where((_atsign) =>
                          //           _atsign?.contains(_searchedText) ?? false)
                          //       .toList();
                          // } else {
                          //   _filteredList = _providerList;
                          // }

                          return Wrap(
                            children:
                                List.generate(_filteredList.length, (index) {
                              if (!_filteredList[index]!
                                  .contains(_searchedText)) {
                                return SizedBox();
                              }

                              AtsignDetails? atsignDetail;
                              String? name;
                              Uint8List? image;
                              var i = Provider.of<FollowService>(context,
                                      listen: false)
                                  .following
                                  .atsignListDetails
                                  .indexWhere((element) =>
                                      element.atcontact.atSign ==
                                      _filteredList[index]!);
                              if (i > -1) {
                                atsignDetail = Provider.of<FollowService>(
                                        context,
                                        listen: false)
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
                                  subTitle: _filteredList[index],
                                  trailingWidget: InkWell(
                                    onTap: () async {
                                      await Provider.of<FollowService>(context,
                                              listen: false)
                                          .unfollow(_filteredList[index]!);
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
                          // var _providerList = _provider.followers.list ?? [];
                          List<String?> _filteredList =
                              _provider.followers.list ?? [];
                          // if (_searchedText.isNotEmpty) {
                          //   _filteredList = _providerList
                          //       .where((_atsign) =>
                          //           _atsign?.contains(_searchedText) ?? false)
                          //       .toList();
                          // } else {
                          //   _filteredList = _providerList;
                          // }

                          return Wrap(
                            children:
                                List.generate(_filteredList.length, (index) {
                              if (!_filteredList[index]!
                                  .contains(_searchedText)) {
                                return SizedBox();
                              }
                              AtsignDetails? atsignDetail;
                              String? name;
                              Uint8List? image;
                              var i = Provider.of<FollowService>(context,
                                      listen: false)
                                  .followers
                                  .atsignListDetails
                                  .indexWhere((element) =>
                                      element.atcontact.atSign ==
                                      _filteredList[index]!);
                              if (i > -1) {
                                atsignDetail = Provider.of<FollowService>(
                                        context,
                                        listen: false)
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

                              bool _isFollowingThisAtsign =
                                  Provider.of<FollowService>(context,
                                          listen: false)
                                      .isFollowing(_filteredList[index]!);

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomPersonHorizontalTile(
                                    title: name != null ? name : null,
                                    subTitle: _filteredList[index],
                                    trailingWidget: InkWell(
                                      onTap: () async {
                                        await Provider.of<FollowService>(
                                                context,
                                                listen: false)
                                            .performFollowUnfollow(
                                                _filteredList[index]!);
                                      },
                                      child: _provider
                                              .followers
                                              .atsignListDetails[index]
                                              .isRmovingFromFollowers
                                          ? CircularProgressIndicator()
                                          : Text(
                                              (_isFollowingThisAtsign
                                                  ? 'Following'
                                                  : 'Follow'),
                                              style: TextStyles.lightText(
                                                  (_isFollowingThisAtsign
                                                      ? ColorConstants.greyText
                                                      : ColorConstants.orange),
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
