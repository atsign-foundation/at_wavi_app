import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_game/desktop_game_account_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_channels/desktop_social/desktop_social_account_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_channels_model.dart';

class DesktopChannelsPage extends StatefulWidget {
  DesktopChannelsPage({Key? key}) : super(key: key);

  _DesktopChannelsPageState _desktopChannelsPageState =
      _DesktopChannelsPageState();

  @override
  _DesktopChannelsPageState createState() => _desktopChannelsPageState;

  Future updateChannelFields() async {
    await _desktopChannelsPageState.updateChannelFields();
  }
}

class _DesktopChannelsPageState extends State<DesktopChannelsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopChannelsPage> {
  late TabController _tabController;

  late DesktopChannelsModel _model;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future updateChannelFields() async {
    if (this.mounted) {
      await showReOderPopUp(
        context,
        (fields) {
          /// Update Fields after reorder
          _model.updateField(fields);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopChannelsModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        child: Consumer<DesktopChannelsModel>(
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
                        tabs: model.fields
                            .map(
                              (e) => Tab(
                                child: Text(
                                  e,
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
        return DesktopSocialAccountPage();
      case 'Game':
        return DesktopGameAccountPage();
      default:
        return Container();
    }
  }
}
