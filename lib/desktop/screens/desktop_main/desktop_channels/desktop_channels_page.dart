import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_game/desktop_game_account_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_social/desktop_social_account_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

class DesktopChannelsPage extends StatefulWidget {
  DesktopChannelsPage({Key? key}) : super(key: key);

  _DesktopChannelsPageState _desktopChannelsPageState = _DesktopChannelsPageState();

  @override
  _DesktopChannelsPageState createState() => _desktopChannelsPageState;

  Future updateSocialFields() async {
    await _desktopChannelsPageState.updateSocialFields();
  }

  Future updateGameFields() async{
    await _desktopChannelsPageState.updateGameFields();
  }
}

class _DesktopChannelsPageState extends State<DesktopChannelsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopChannelsPage> {
  late TabController _tabController;

  DesktopSocialAccountPage desktopSocialAccountPage = DesktopSocialAccountPage();
  DesktopGameAccountPage desktopGameAccountPage = DesktopGameAccountPage();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future updateSocialFields() async {
    await desktopSocialAccountPage.updateFields();
  }

  Future updateGameFields() async{
    await desktopGameAccountPage.updateFields();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      child: Column(
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
                right: 8,
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
            tabs: [
              Tab(
                child: Text(
                  Strings.desktop_social_accounts,
                ),
              ),
              Tab(
                child: Text(
                  Strings.desktop_game_accounts,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                desktopSocialAccountPage,
                desktopGameAccountPage,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          currentScreen = AtCategory.SOCIAL.name;
          break;
        case 1:
          currentScreen = AtCategory.GAMER.name;
          break;
      }
    }
  }
}
