import 'package:at_wavi_app/common_components/provider_callback.dart';
import 'package:at_wavi_app/desktop/screens/desktop_user_profile/desktop_user_profile_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_label_button.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_preview_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_welcome_widget.dart';
import 'package:at_wavi_app/model/basic_data_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_add_location/desktop_add_location_page.dart';
import 'desktop_profile_add_custom_field/desktop_profile_add_custom_field.dart';
import 'desktop_profile_basic_info_model.dart';
import 'desktop_edit_basic_detail/desktop_edit_basic_detail_page.dart';
import 'desktop_reorder_basic_info/desktop_reorder_basic_info_page.dart';
import 'widgets/desktop_basic_info_widget.dart';
import 'widgets/desktop_empty_category_widget.dart';
import 'widgets/desktop_location_item_widget.dart';

class DesktopProfileBasicInfoPage extends StatefulWidget {
  final AtCategory atCategory;
  final bool hideMenu;
  final bool showWelcome;
  final bool isMyProfile;
  final bool isEditable;

  const DesktopProfileBasicInfoPage({
    Key? key,
    required this.atCategory,
    this.hideMenu = false,
    this.showWelcome = true,
    required this.isMyProfile,
    required this.isEditable,
  }) : super(key: key);

  @override
  _DesktopProfileBasicInfoPageState createState() =>
      _DesktopProfileBasicInfoPageState();
}

class _DesktopProfileBasicInfoPageState
    extends State<DesktopProfileBasicInfoPage>
    with AutomaticKeepAliveClientMixin {
  late DesktopBasicDetailModel _model;
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        final userProvider = Provider.of<UserProvider>(context);
        _model = DesktopBasicDetailModel(
          isMyProfile: widget.isMyProfile,
          userPreview: userPreview,
          userProvider: userProvider,
          atCategory: widget.atCategory,
        );
        return _model;
      },
      child: Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Consumer<DesktopBasicDetailModel>(
      builder: (_, model, child) {
        if (model.isEmptyData) {
          return _buildEmptyWidget();
        } else {
          return _buildContentWidget(
            model.basicData,
            locationData: model.locationData,
          );
        }
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.showWelcome)
          Container(
            padding: EdgeInsets.only(top: DesktopDimens.paddingLarge),
            child: DesktopWelcomeWidget(
              titlePage: widget.atCategory.titlePage,
            ),
          ),
        Expanded(
          child: Container(
            child: Center(
              child: DesktopEmptyCategoryWidget(
                atCategory: widget.atCategory,
                onAddDetailsPressed: widget.atCategory == AtCategory.LOCATION
                    ? _showAddLocation
                    : _showAddDetailPopup,
                showAddButton: widget.isEditable,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentWidget(List<BasicDataModel> data,
      {BasicData? locationData}) {
    final appTheme = AppTheme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DesktopDimens.paddingExtraLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.hideMenu == false)
            SizedBox(height: DesktopDimens.paddingLarge),
          if (widget.hideMenu == false)
            Container(
              child: Row(
                children: [
                  Text(
                    widget.atCategory.label,
                    style: TextStyle(
                      color: appTheme.primaryTextColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (widget.atCategory != AtCategory.LOCATION)
                    DesktopIconLabelButton(
                      iconData: Icons.add_circle_outline_sharp,
                      label: 'Custom Content',
                      onPressed: _showAddCustomContent,
                    ),
                  if (widget.atCategory == AtCategory.LOCATION)
                    DesktopIconLabelButton(
                      iconData: Icons.add_circle_outline_sharp,
                      label: 'Add location',
                      onPressed: _showAddLocation,
                    ),
                  DesktopIconButton(
                    iconData: Icons.edit_rounded,
                    onPressed: _showAddDetailPopup,
                  ),
                  SizedBox(width: 10),
                  DesktopPreviewButton(
                    onPressed: _showUserPreview,
                  ),
                ],
              ),
            ),
          if (widget.hideMenu == false)
            SizedBox(height: DesktopDimens.paddingLarge),
          Expanded(
            child: Container(
              child: _buildFieldsWidget(data, locationData: locationData),
            ),
          ),
          SizedBox(height: DesktopDimens.paddingNormal),
          if (widget.isEditable)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.atCategory != AtCategory.LOCATION)
                  DesktopWhiteButton(
                    title: 'Reorder',
                    onPressed: _showReorderDetailPopup,
                  ),
                SizedBox(width: 12),
                DesktopButton(
                  title: 'Save & Next',
                  onPressed: _handleSaveAndNext,
                ),
              ],
            ),
          if (widget.isEditable) SizedBox(height: DesktopDimens.paddingLarge),
        ],
      ),
    );
  }

  Widget _buildFieldsWidget(List<BasicDataModel> data,
      {BasicData? locationData}) {
    if (widget.atCategory == AtCategory.LOCATION) {
      return _buildLocationFieldWidget(data, locationData: locationData);
    }

    final appTheme = AppTheme.of(context);
    return ListView.separated(
      controller: _scrollController,
      itemBuilder: (context, index) {
        final item = data[index];
        BorderRadius? borderRadius;
        if (data.length == 1) {
          borderRadius = BorderRadius.all(Radius.circular(10));
        } else {
          if (index == 0) {
            borderRadius = BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            );
          } else if (index == data.length - 1) {
            borderRadius = BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            );
          }
        }
        return Container(
          decoration: BoxDecoration(
            color: appTheme.secondaryBackgroundColor,
            borderRadius: borderRadius,
          ),
          child: DesktopBasicInfoWidget(
            data: item.data,
            isCustomField: item.isCustomField,
            onDeletePressed: () {
              _model.deleteData(item.data);
            },
            onEditPressed: () {
              _showEditCustomContent(item.data);
            },
          ),
          // child: item.data.extension != null
          //     ? DesktopMediaItemWidget(
          //         data: item.data,
          //       )
          //     : DesktopBasicDetailItemWidget(
          //         title: item.data.accountName ?? '',
          //         description: item.data.value ?? '',
          //       ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: DesktopDimens.paddingNormal),
          color: appTheme.secondaryBackgroundColor,
          child: Container(
            color: appTheme.separatorColor,
            height: DesktopDimens.dividerHeight,
          ),
        );
      },
      itemCount: data.length,
    );
  }

  Widget _buildLocationFieldWidget(List<BasicDataModel> data,
      {BasicData? locationData}) {
    final appTheme = AppTheme.of(context);
    return ListView.separated(
      controller: _scrollController,
      itemBuilder: (context, index) {
        BorderRadius? borderRadius;
        if (data.length == 1) {
          borderRadius = BorderRadius.all(Radius.circular(10));
        } else {
          if (index == 1) {
            borderRadius = BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            );
          } else if (index == data.length) {
            borderRadius = BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            );
          }
        }
        if (index == 0) {
          print(_model.locationData?.value);
          return Container(
            decoration: BoxDecoration(
              color: appTheme.secondaryBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: DesktopLocationItemWidget(
              title: _model.locationNicknameData?.value ?? '',
              location: _model.locationData?.value as String?,
            ),
          );
        }

        final item = data[index - 1];
        return Container(
          decoration: BoxDecoration(
            color: appTheme.secondaryBackgroundColor,
            borderRadius: borderRadius,
          ),
          child: DesktopLocationItemWidget(
            title: item.data.accountName,
            location: item.data.value,
          ),
        );
      },
      separatorBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              'More Locations',
              style: TextStyle(
                  color: appTheme.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          color: appTheme.secondaryBackgroundColor,
          child: Container(
            color: appTheme.separatorColor,
            height: 2,
          ),
        );
      },
      itemCount: data.length + 1,
    );
  }

  void _showAddDetailPopup() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopEditBasicDetailPage(
          atCategory: widget.atCategory,
        ),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showUserPreview() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DesktopUserProfilePage(),
      ),
    );
  }

  void _showAddCustomContent() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopProfileAddCustomField(
          atCategory: widget.atCategory,
        ),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showEditCustomContent(BasicData data) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopProfileAddCustomField(
          atCategory: widget.atCategory,
          data: data,
        ),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showAddLocation() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopAddLocationPage(),
      ),
    );
    if (result == 'saved') {
      _model.fetchBasicData();
    }
  }

  void _showReorderDetailPopup() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopReorderBasicDetailPage(
          atCategory: widget.atCategory,
        ),
      ),
    );
    if (result != null) {
      _model.fetchBasicData();
    }
  }

  void _handleSaveAndNext() async {
    await providerCallback<UserProvider>(
      context,
      task: (provider) async {
        await provider.saveUserData(
            Provider.of<UserPreview>(context, listen: false).user()!);
      },
      onError: (provider) {},
      showDialog: false,
      text: 'Saving user data',
      taskName: (provider) => provider.UPDATE_USER,
      onSuccess: (provider) async {
        Navigator.pop(context, 'saved');
        // await SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
      },
    );
  }
}
