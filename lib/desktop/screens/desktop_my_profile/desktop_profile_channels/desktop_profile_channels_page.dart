import 'package:at_wavi_app/desktop/screens/desktop_my_profile/desktop_profile_details/desktop_basic_detail/desktop_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_profile_basic_info_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_tabbar.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_profile_channels_model.dart';

class DesktopProfileChannelsPage extends StatefulWidget {
  DesktopProfileChannelsPage({
    Key? key,
  }) : super(key: key);

  _DesktopProfileChannelsPageState _desktopChannelsPageState =
      _DesktopProfileChannelsPageState();

  @override
  _DesktopProfileChannelsPageState createState() => _desktopChannelsPageState;

  Future showReOrderTabsPopUp() async {
    await _desktopChannelsPageState.showReOrderTabsPopUp();
  }

  Future addFieldToSocial() async {
    await _desktopChannelsPageState.addFieldToSocial();
  }

  Future addFieldToGame() async {
    await _desktopChannelsPageState.addFieldToGame();
  }
}

class _DesktopProfileChannelsPageState extends State<DesktopProfileChannelsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopProfileChannelsPage> {
  late TabController _tabController;
  late DesktopProfileChannelsModel _model;

  late DesktopBasicDetailPage desktopSocialAccountPage;
  late DesktopBasicDetailPage desktopGameAccountPage;

  final _pageController = PageController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    desktopSocialAccountPage = DesktopBasicDetailPage(
      atCategory: AtCategory.SOCIAL,
    );
    desktopGameAccountPage = DesktopBasicDetailPage(
      atCategory: AtCategory.GAMER,
    );

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

  Future addFieldToSocial() async {
    await desktopSocialAccountPage.addField();
  }

  Future addFieldToGame() async {
    await desktopGameAccountPage.addField();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopProfileChannelsModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        child: Consumer<DesktopProfileChannelsModel>(
          builder: (_, model, child) {
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
                                  e,
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
      case 'Social':
        return desktopSocialAccountPage;
      case 'Game':
        return desktopGameAccountPage;
      default:
        return Container();
    }
  }
}
