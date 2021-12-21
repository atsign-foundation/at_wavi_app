import 'package:at_wavi_app/common_components/provider_callback.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_edit_basic_detail/desktop_edit_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_profile_add_custom_field/desktop_profile_add_custom_field.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_profile_media/widgets/desktop_media_item.dart';
import 'package:at_wavi_app/desktop/screens/desktop_user_profile/desktop_user_profile_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_preview_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_profile_media_model.dart';

class DesktopProfileMediaPage extends StatefulWidget {
  final AtCategory atCategory = AtCategory.IMAGE;
  final bool hideMenu;
  final bool showWelcome;
  final bool isMyProfile;
  final bool isEditable;

  const DesktopProfileMediaPage({
    Key? key,
    this.hideMenu = false,
    this.showWelcome = true,
    required this.isMyProfile,
    required this.isEditable,
  }) : super(key: key);

  @override
  _DesktopProfileMediaPageState createState() =>
      _DesktopProfileMediaPageState();
}

class _DesktopProfileMediaPageState extends State<DesktopProfileMediaPage>
    with AutomaticKeepAliveClientMixin {
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
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: _buildContentWidget(),
    );
  }

  // Widget _buildBodyWidget() {
  //   return Consumer<DesktopProfileMediaModel>(
  //     builder: (_, model, child) {
  //       // if (model.isEmptyData) {
  //       //   return _buildEmptyWidget();
  //       // } else {
  //       return _buildContentWidget(model.mediaFields);
  //       // }
  //     },
  //   );
  // }

  // Widget _buildEmptyWidget() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       if (widget.showWelcome)
  //         Container(
  //           padding: EdgeInsets.only(top: DesktopDimens.paddingLarge),
  //           child: DesktopWelcomeWidget(
  //             titlePage: widget.atCategory.titlePage,
  //           ),
  //         ),
  //       Expanded(
  //         child: Container(
  //           child: Center(
  //             child: DesktopEmptyCategoryWidget(
  //               atCategory: widget.atCategory,
  //               onAddDetailsPressed: widget.atCategory == AtCategory.LOCATION
  //                   ? _showAddLocation
  //                   : _showAddDetailPopup,
  //               showAddButton: false,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildContentWidget() {
    User? user;
    if (widget.isMyProfile && widget.isEditable == false) {
      user = Provider.of<UserProvider>(context).user;
    } else {
      user = Provider.of<UserPreview>(context).user();
    }
    List<BasicData>? customFields =
        user?.customFields[AtCategory.IMAGE.name] ?? [];
    final items = customFields;

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
                  DesktopIconButton(
                    iconData: Icons.add_circle_outline_sharp,
                    onPressed: _showAddCustomContent,
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
              child: _buildFieldsWidget(items),
            ),
          ),
          SizedBox(height: DesktopDimens.paddingNormal),
          if (widget.isEditable)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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

  Widget _buildFieldsWidget(List<BasicData> items) {
    return Container(
      width: double.infinity,
      child: GridView.count(
        controller: _scrollController,
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        children: items
            .map((e) => DesktopMediaItem(
                  data: e,
                  showMenu: widget.isEditable,
                  onEditPressed: () {
                    _editData(e);
                  },
                  onDeletePressed: () {
                    _deleteData(e);
                  },
                ))
            .toList(),
      ),
    );
  }

  // void _showAddDetailPopup() async {
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopEditBasicDetailPage(
  //         atCategory: widget.atCategory,
  //       ),
  //     ),
  //   );
  //   if (result == 'saved') {
  //     _model.fetchBasicData();
  //   }
  // }

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
          allowContentType: [
            CustomContentType.Image,
          ],
        ),
      ),
    );
    // if (result == 'saved') {
    //   _model.fetchBasicData();
    // }
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
    // if (result == 'saved') {
    //   _model.fetchBasicData();
    // }
  }

  // void _showAddLocation() async {
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopAddLocationPage(),
  //     ),
  //   );
  //   if (result == 'saved') {
  //     _model.fetchBasicData();
  //   }
  // }
  //
  // void _showReorderDetailPopup() async {
  //   final result = await showDialog<List<String>>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopReorderBasicDetailPage(
  //         atCategory: widget.atCategory,
  //       ),
  //     ),
  //   );
  //   if (result != null) {
  //     _model.fetchBasicData();
  //   }
  // }
  void _deleteData(BasicData basicData) {
    UserPreview().deletCustomField(AtCategory.IMAGE, basicData);
    setState(() {});
  }

  void _editData(BasicData basicData) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopProfileAddCustomField(
          atCategory: AtCategory.IMAGE,
          data: basicData,
          allowContentType: [
            CustomContentType.Image,
          ],
        ),
      ),
    );
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
