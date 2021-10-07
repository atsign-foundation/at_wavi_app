import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_profile_featured_model.dart';
import 'desktop_instagram_page.dart';
import 'desktop_twitter_page.dart';

class DesktopProfileFeaturedPage extends StatefulWidget {
  DesktopProfileFeaturedPage({
    Key? key,
  }) : super(key: key);

  _DesktopProfileFeaturedPageState _desktopFeaturedPageState =
      _DesktopProfileFeaturedPageState();

  @override
  _DesktopProfileFeaturedPageState createState() => _desktopFeaturedPageState;

  Future showReOrderTabsPopUp() async {
    await _desktopFeaturedPageState.showReOrderTabsPopUp();
  }

  Future addFieldToInstagram(BasicData basicData) async {
    await _desktopFeaturedPageState.addFieldToInstagram(basicData);
  }

  Future addFieldToTwitter(BasicData basicData) async {
    await _desktopFeaturedPageState.addFieldToTwitter(basicData);
  }
}

class _DesktopProfileFeaturedPageState extends State<DesktopProfileFeaturedPage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopProfileFeaturedPage> {
  late TabController _tabController;

  late DesktopProfileFeaturedModel _model;

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future showReOrderTabsPopUp() async {
    if (this.mounted) {
      await showReOderTabsPopUp(
        context,
        (fields) {
          /// Update Fields after reorder
          _model.updateField(fields);
        },
      );
    }
  }

  Future addFieldToInstagram(BasicData basicData) async {}

  Future addFieldToTwitter(BasicData basicData) async {}

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopProfileFeaturedModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        child: Consumer<DesktopProfileFeaturedModel>(
          builder: (_, model, child) {
            _tabController =
                TabController(length: model.fields.length, vsync: this);
            return model.fields.isEmpty
                ? Container()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 3,
                            color: appTheme.primaryColor,
                          ),
                          insets: EdgeInsets.only(
                            left: 0,
                            right: 12,
                            bottom: 4,
                          ),
                        ),
                        //    indicatorColor: appTheme.primaryColor,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 13,
                          color: appTheme.borderColor,
                          fontFamily: 'Inter',
                        ),
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: appTheme.primaryTextColor,
                          fontFamily: 'Inter',
                        ),
                        controller: _tabController,
                        tabs: model.fields
                            .map(
                              (e) => Tab(
                                child: Text(
                                  getTitle(e),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: appTheme.primaryTextColor,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: model.fields
                              .map(
                                (e) => getWidget(e),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget getWidget(String field) {
    switch (field) {
      case 'instagram':
        return DesktopInstagramPage();
      case 'twitter':
        return DesktopTwitterPage();
      default:
        return Container();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
