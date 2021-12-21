import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_tutorial/desktop_tutorial_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'desktop_main_detail_model.dart';
import 'desktop_profile_channels/desktop_profile_channels_page.dart';
import 'desktop_profile_details/desktop_profile_details_page.dart';
import 'widgets/desktop_profile_tabbar.dart';

class DesktopProfileDataPage extends StatefulWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingPressed;
  final bool isMyProfile;
  final bool isEditable;

  DesktopProfileDataPage({
    Key? key,
    this.onSearchPressed,
    this.onSettingPressed,
    required this.isMyProfile,
    required this.isEditable,
  }) : super(key: key);

  @override
  _DesktopProfileDataPageState createState() => _DesktopProfileDataPageState();
}

class _DesktopProfileDataPageState extends State<DesktopProfileDataPage>
    with TickerProviderStateMixin {
  late PageController _pageController;

  late DesktopMainDetailModel _model;

  late List<PopupMenuEntry<String>> menuDetails;
  late List<PopupMenuEntry<String>> menuLocations;
  late List<PopupMenuEntry<String>> menuMedias;

  late TabController _tabController;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    PopupMenuItem<String> popupMenuItem = PopupMenuItem<String>(
      value: 'reorder',
      child: Text(
        Strings.desktop_reorder,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
        ),
      ),
    );

    menuDetails = <PopupMenuEntry<String>>[
      popupMenuItem,
      PopupMenuItem<String>(
        value: 'add_custom_content',
        child: Text(
          Strings.desktop_add_custom_content,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
          ),
        ),
      ),
    ];

    menuLocations = <PopupMenuEntry<String>>[
      popupMenuItem,
      PopupMenuItem<String>(
        value: 'add_location',
        child: Text(
          Strings.desktop_add_location,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
          ),
        ),
      ),
    ];

    menuMedias = <PopupMenuEntry<String>>[
      popupMenuItem,
      PopupMenuItem<String>(
        value: 'add_media',
        child: Text(
          Strings.desktop_add_media,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
          ),
        ),
      ),
    ];

    _pageController = PageController();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   //clearSharedPreferences();
    //   saveStringToSharedPreferences(
    //       key: Strings.desktop_current_tab, value: AtCategory.DETAILS_TAB.name);
    // });
    super.initState();
    _showTutorial();
  }

  void _showTutorial() async {
    final isFirstTimeOpen = await SharedPreferencesUtils.isFirstTimeOpen();
    if (isFirstTimeOpen) {
      _showTutorialDialog();
    }
    await SharedPreferencesUtils.setFirstTimeOpen(isFirstTime: false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopMainDetailModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        color: appTheme.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: DesktopDimens.paddingLarge),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesktopDimens.paddingLarge,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(), flex: 1),
                  DesktopProfileTabBar(
                    onTap: (index) {
                      _pageController.jumpToPage(index);
                    },
                    tab: _tabController,
                  ),
                  Expanded(
                    flex: 1,
                    child: widget.isMyProfile
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DesktopIconButton(
                                iconData: Icons.search,
                                iconColor: appTheme.primaryTextColor,
                                backgroundColor:
                                    appTheme.secondaryBackgroundColor,
                                onPressed: () {
                                  widget.onSearchPressed?.call();
                                },
                              ),
                              SizedBox(width: DesktopDimens.paddingSmall),
                              // DesktopIconButton(
                              //   iconData: Icons.notifications,
                              //   iconColor: appTheme.primaryTextColor,
                              //   backgroundColor:
                              //       appTheme.secondaryBackgroundColor,
                              //   onPressed: _showNotificationPopup,
                              // ),
                              if (widget.isMyProfile &&
                                  widget.isEditable == false)
                                RotationTransition(
                                  turns: _animation,
                                  child: DesktopIconButton(
                                    iconData: Icons.sync,
                                    iconColor: appTheme.primaryTextColor,
                                    backgroundColor:
                                        appTheme.secondaryBackgroundColor,
                                    onPressed: _syncData,
                                  ),
                                ),
                              SizedBox(width: DesktopDimens.paddingSmall),
                              DesktopIconButton(
                                iconData: Icons.more_vert,
                                iconColor: appTheme.primaryTextColor,
                                backgroundColor:
                                    appTheme.secondaryBackgroundColor,
                                onPressed: () {
                                  widget.onSettingPressed?.call();
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: DesktopDimens.paddingNormal,
            ),
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int page) {},
                    controller: _pageController,
                    children: [
                      DesktopProfileDetailsPage(
                        isMyProfile: widget.isMyProfile,
                        isEditable: widget.isEditable,
                      ),
                      DesktopProfileChannelsPage(
                        isMyProfile: widget.isMyProfile,
                        isEditable: widget.isEditable,
                      ),
                    ],
                  ),
                  // Positioned(
                  //   top: 10,
                  //   right: DesktopDimens.paddingLarge,
                  //   child: Visibility(
                  //     visible: widget.isMyProfile,
                  //     child: GestureDetector(
                  //       onTapDown: (details) =>
                  //           showPopUpMenuAtTap(context, details),
                  //       child: Container(
                  //         height: 32,
                  //         width: 32,
                  //         decoration: BoxDecoration(
                  //           color: appTheme.secondaryBackgroundColor,
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: Icon(
                  //           Icons.edit_rounded,
                  //           size: 16,
                  //           color: appTheme.primaryTextColor,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future _clickReOrder() async {
  //   var currentScreen =
  //       await getStringFromSharedPreferences(key: Strings.desktop_current_tab);
  //   switch (currentScreen) {
  //     case 'DETAILS_TAB':
  //       await profileDetailsPage.showReOrderTabsPopUp();
  //       break;
  //     case 'CHANNELS':
  //       await profileChannelsPage.showReOrderTabsPopUp();
  //       break;
  //     // case 'FEATURED':
  //     //   await profileFeaturedPage.showReOrderTabsPopUp();
  //     //   break;
  //   }
  // }

  // Future _clickAddCustomContent() async {
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopProfileAddCustomField(
  //         atCategory: AtCategory.CHANNELS, //todo: remove hard code
  //       ),
  //     ),
  //   );
  //   if (result != null) {
  //     if (result == 'saved') {
  //       var currentScreen = await getStringFromSharedPreferences(
  //         key: Strings.desktop_current_screen,
  //       );
  //       switch (currentScreen) {
  //         case 'DETAILS':
  //           await profileDetailsPage.addFieldToBasicDetail();
  //           break;
  //         case 'ADDITIONAL_DETAILS':
  //           await profileDetailsPage.addFieldToAdditionalDetail();
  //           break;
  //         case 'SOCIAL':
  //           await profileChannelsPage.addFieldToSocial();
  //           break;
  //         case 'GAMER':
  //           await profileChannelsPage.addFieldToGame();
  //           break;
  //         //Todo
  //         case 'MixedConstants.INSTAGRAM_KEY':
  //           break;
  //         case 'MixedConstants.TWITTER_KEY':
  //           break;
  //       }
  //     }
  //   }
  // }

  // Future _clickAddLocation() async {
  //   print('_clickAddLocation');
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopAddLocationPage(),
  //     ),
  //   );
  //   if (result != null) {
  //     if (result == 'saved') {
  //       await profileDetailsPage.addLocation();
  //     }
  //   }
  // }

  // Future _clickAddMedia() async {
  //   print('_clickAddMedia');
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: DesktopProfileAddCustomField(
  //         isOnlyAddImage: true,
  //         atCategory: AtCategory.IMAGE,
  //       ),
  //     ),
  //   );
  //   if (result != null) {
  //     if (result == 'saved') {
  //       await profileDetailsPage.addMedia();
  //     }
  //   }
  // }

  // void showPopUpMenuAtTap(BuildContext context, TapDownDetails details) async {
  //   var currentScreen = await getStringFromSharedPreferences(
  //     key: Strings.desktop_current_screen,
  //   );
  //   List<PopupMenuEntry<String>> menus = [];
  //   switch (currentScreen) {
  //     case 'IMAGE':
  //       menus = menuMedias;
  //       break;
  //     case 'LOCATION':
  //       menus = menuLocations;
  //       break;
  //     default:
  //       menus = menuDetails;
  //       break;
  //   }
  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(
  //       details.globalPosition.dx,
  //       details.globalPosition.dy,
  //       details.globalPosition.dx,
  //       details.globalPosition.dy,
  //     ),
  //     items: menus,
  //   ).then((value) async {
  //     switch (value) {
  //       case 'reorder':
  //         await _clickReOrder();
  //         break;
  //       case 'add_custom_content':
  //         await _clickAddCustomContent();
  //         break;
  //       case 'add_location':
  //         await _clickAddLocation();
  //         break;
  //       case 'add_media':
  //         await _clickAddMedia();
  //         break;
  //     }
  //   });
  // }

  void _showTutorialDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => DesktopTutorialPage(),
    );
  }

  void _showNotificationPopup() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => DesktopNotificationPage(),
        barrierColor: Colors.transparent);
  }

  void _syncData() async {
    _controller.reset();
    _controller.forward();
    await BackendService().sync();
    setState(() {});
  }
}
