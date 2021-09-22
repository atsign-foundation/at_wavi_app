import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_additional_detail/desktop_additional_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_basic_detail/desktop_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_location/desktop_location_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_media/desktop_media_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_details_model.dart';

class DesktopDetailsPage extends StatefulWidget {
  DesktopDetailsPage({Key? key}) : super(key: key);

  _DesktopDetailsPageState _desktopDetailsPageState =
      _DesktopDetailsPageState();

  @override
  _DesktopDetailsPageState createState() => _desktopDetailsPageState;

  Future updateDetailFields() async {
    await _desktopDetailsPageState.updateDetailFields();
  }
}

class _DesktopDetailsPageState extends State<DesktopDetailsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<DesktopDetailsPage> {
  late TabController _tabController;

  late DesktopDetailsModel _model;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future updateDetailFields() async {
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
        _model = DesktopDetailsModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        child: Consumer<DesktopDetailsModel>(
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget getWidget(String field) {
    switch (field) {
      case 'Media':
        return DesktopMediaPage();
      case 'Basic Details':
        return DesktopBasicDetailPage();
      case 'Additional Details':
        return DesktopAdditionalDetailPage();
      case 'Location':
        return DesktopLocationPage();
      default:
        return Container();
    }
  }
}
