import 'dart:typed_data';

import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/person_horizontal_tile.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Following extends StatefulWidget {
  final bool forSearchedAtsign;
  final int tabIndex;
  final ThemeData themeData;
  Following(
      {required this.themeData,
      this.forSearchedAtsign = false,
      this.tabIndex = 0});

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
        TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('forSearchedAtsign ${widget.forSearchedAtsign}');
    // SizeConfig().init(context);
    return Scaffold(
      backgroundColor: widget.themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 25, right: 25),
          // color: ColorConstants.white,
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
                  child: Icon(
                    Icons.arrow_back,
                    color: widget.themeData.primaryColor,
                  ),
                ),
                centerWidget: Text(
                  widget.forSearchedAtsign
                      ? SearchService().user.atsign
                      : BackendService().atClientInstance.currentAtSign!,
                  style: TextStyles.boldText(widget.themeData.primaryColor,
                      size: 18),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                // trailing: Icon(Icons.public),
              ),
              SizedBox(height: 35),
              TabBar(
                onTap: (index) async {},
                labelColor: widget.themeData.primaryColor,
                indicatorWeight: 5.toHeight,
                indicatorColor: ColorConstants.peach,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor:
                    widget.themeData.primaryColor.withOpacity(0.5),
                controller: _controller,
                tabs: [
                  Text(
                    'Following',
                    style: TextStyle(
                      letterSpacing: 0.1,
                      fontSize: 18.toFont,
                    ),
                  ),
                  Text(
                    'Followers',
                    style: TextStyle(
                      letterSpacing: 0.1,
                      fontSize: 18.toFont,
                    ),
                  )
                ],
              ),
              Divider(height: 1),
              SizedBox(height: 25),
              CustomInputField(
                inputFieldColor: ColorConstants.MILD_GREY,
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
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Consumer<FollowService>(
                          builder: (context, _provider, _) {
                        List<String?> _filteredList =
                            _provider.following.list ?? [];

                        if (widget.forSearchedAtsign) {
                          _filteredList = SearchService().following ?? [];
                        }

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
                              atsignDetail = Provider.of<FollowService>(context,
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

                            bool _isFollowingThisAtsign =
                                Provider.of<FollowService>(context,
                                        listen: false)
                                    .isFollowing(_filteredList[index]!);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomPersonHorizontalTile(
                                textColor: widget.themeData.primaryColor,
                                title: name != null ? name : null,
                                subTitle: _filteredList[index],
                                trailingWidget: InkWell(
                                  onTap: () async {
                                    await Provider.of<FollowService>(context,
                                            listen: false)
                                        .performFollowUnfollow(
                                            _filteredList[index]!);
                                  },
                                  child: (!widget.forSearchedAtsign &&
                                          _provider
                                              .following
                                              .atsignListDetails[index]
                                              .isUnfollowing)
                                      ? CircularProgressIndicator()
                                      : Text(
                                          _isFollowingThisAtsign
                                              ? 'Unfollow'
                                              : 'Follow',
                                          style: TextStyles.lightText(
                                              _isFollowingThisAtsign
                                                  ? ColorConstants.orange
                                                  : ColorConstants.greyText,
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
                      physics: BouncingScrollPhysics(),
                      child: Consumer<FollowService>(
                          builder: (context, _provider, _) {
                        List<String?> _filteredList =
                            _provider.followers.list ?? [];

                        if (widget.forSearchedAtsign) {
                          _filteredList = SearchService().followers ?? [];
                        }

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
                              atsignDetail = Provider.of<FollowService>(context,
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
                                  textColor: widget.themeData.primaryColor,
                                  title: name != null ? name : null,
                                  subTitle: _filteredList[index],
                                  trailingWidget: InkWell(
                                    onTap: () async {
                                      await Provider.of<FollowService>(context,
                                              listen: false)
                                          .performFollowUnfollow(
                                              _filteredList[index]!);
                                    },
                                    child: (!widget.forSearchedAtsign &&
                                            _provider
                                                .followers
                                                .atsignListDetails[index]
                                                .isRmovingFromFollowers)
                                        ? CircularProgressIndicator()
                                        : Text(
                                            (_isFollowingThisAtsign
                                                ? 'Unfollow'
                                                : 'Follow'),
                                            style: TextStyles.lightText(
                                                (_isFollowingThisAtsign
                                                    ? ColorConstants.orange
                                                    : ColorConstants.greyText),
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
    );
  }
}
