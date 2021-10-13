import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_add_location/desktop_add_location_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_profile_add_custom_field/desktop_profile_add_custom_field.dart';
import 'package:at_wavi_app/desktop/screens/desktop_tutorial/desktop_tutorial_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'desktop_main_detail_model.dart';
import 'desktop_profile_channels/desktop_profile_channels_page.dart';
import 'desktop_profile_details/desktop_profile_details_page.dart';
import 'desktop_profile_featured/desktop_profile_featured_page.dart';
import 'widgets/desktop_profile_tabbar.dart';

class DesktopMainDetailPage extends StatefulWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingPressed;

  DesktopMainDetailPage({
    Key? key,
    this.onSearchPressed,
    this.onSettingPressed,
  }) : super(key: key);

  @override
  _DesktopMainDetailPageState createState() => _DesktopMainDetailPageState();
}

class _DesktopMainDetailPageState extends State<DesktopMainDetailPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  late DesktopMainDetailModel _model;

  late DesktopProfileDetailsPage profileDetailsPage;
  late DesktopProfileChannelsPage profileChannelsPage;
  late DesktopProfileFeaturedPage profileFeaturedPage;

  late List<PopupMenuEntry<String>> menuDetails;
  late List<PopupMenuEntry<String>> menuLocations;
  late List<PopupMenuEntry<String>> menuMedias;

  late TabController _tabController;

  @override
  void initState() {
    profileDetailsPage = DesktopProfileDetailsPage();
    profileChannelsPage = DesktopProfileChannelsPage();
    profileFeaturedPage = DesktopProfileFeaturedPage();

    _tabController = TabController(length: 3, vsync: this);

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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //clearSharedPreferences();
      saveStringToSharedPreferences(
          key: Strings.desktop_current_tab, value: AtCategory.DETAILS_TAB.name);
    });
    super.initState();
    _showTutorial();
  }

  void _showTutorial() async {
    await Future.delayed(Duration(seconds: 1));
    _showTutorialDialog();
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
      child: ShowCaseWidget(
        onStart: (index, key) {},
        onComplete: (index, key) {},
        builder: Builder(
          builder: (context) => Container(
            color: appTheme.backgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: 64,
              vertical: 40,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DesktopIconButton(
                            iconData: Icons.search,
                            iconColor: appTheme.primaryTextColor,
                            backgroundColor: appTheme.secondaryBackgroundColor,
                            onPressed: () {
                              widget.onSearchPressed?.call();
                            },
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          PopupMenuButton<String>(
                            padding: EdgeInsets.all(0),
                            child: DesktopIconButton(
                              iconData: Icons.notifications,
                              iconColor: appTheme.primaryTextColor,
                              backgroundColor:
                                  appTheme.secondaryBackgroundColor,
                              // onPressed: (){},
                            ),
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: 'notification',
                                padding: EdgeInsets.all(0),
                                child: DesktopNotificationPage(
                                  atSign: '',
                                  mainContext: context,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          DesktopIconButton(
                            iconData: Icons.more_vert,
                            iconColor: appTheme.primaryTextColor,
                            backgroundColor: appTheme.secondaryBackgroundColor,
                            onPressed: () {
                              widget.onSettingPressed?.call();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PageView(
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (int page) {},
                        controller: _pageController,
                        children: [
                          profileDetailsPage,
                          profileChannelsPage,
                          profileFeaturedPage,
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTapDown: (details) =>
                              showPopUpMenuAtTap(context, details),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(90),
                              color: appTheme.borderColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorConstants.blackShade2,
                            ),
                          ),
                        ),
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

  Future _clickReOrder() async {
    var currentScreen =
        await getStringFromSharedPreferences(key: Strings.desktop_current_tab);
    switch (currentScreen) {
      case 'DETAILS_TAB':
        await profileDetailsPage.showReOrderTabsPopUp();
        break;
      case 'CHANNELS':
        await profileChannelsPage.showReOrderTabsPopUp();
        break;
      case 'FEATURED':
        await profileFeaturedPage.showReOrderTabsPopUp();
        break;
    }
  }

  Future _clickAddCustomContent() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopProfileAddCustomField(),
      ),
    );
    if (result != null) {
      if (result == 'saved') {
        var currentScreen = await getStringFromSharedPreferences(
          key: Strings.desktop_current_screen,
        );
        switch (currentScreen) {
          case 'DETAILS':
            await profileDetailsPage.addFieldToBasicDetail();
            break;
          case 'ADDITIONAL_DETAILS':
            await profileDetailsPage.addFieldToAdditionalDetail();
            break;
          case 'SOCIAL':
            await profileChannelsPage.addFieldToSocial();
            break;
          case 'GAMER':
            await profileChannelsPage.addFieldToGame();
            break;
          //Todo
          case 'MixedConstants.INSTAGRAM_KEY':
            break;
          case 'MixedConstants.TWITTER_KEY':
            break;
        }
      }
    }
  }

  Future _clickAddLocation() async {
    print('_clickAddLocation');
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopAddLocationPage(),
      ),
    );
    if (result != null) {
      if (result == 'saved') {
        await profileDetailsPage.addLocation();
      }
    }
  }

  Future _clickAddMedia() async {
    print('_clickAddMedia');
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopProfileAddCustomField(
          isOnlyAddImage: true,
        ),
      ),
    );
    if (result != null) {
      if (result == 'saved') {
        await profileDetailsPage.addMedia();
      }
    }
  }

  void showPopUpMenuAtTap(BuildContext context, TapDownDetails details) async {
    var currentScreen = await getStringFromSharedPreferences(
      key: Strings.desktop_current_screen,
    );
    List<PopupMenuEntry<String>> menus = [];
    switch (currentScreen) {
      case 'IMAGE':
        menus = menuMedias;
        break;
      case 'LOCATION':
        menus = menuLocations;
        break;
      default:
        menus = menuDetails;
        break;
    }
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: menus,
    ).then((value) async {
      switch (value) {
        case 'reorder':
          await _clickReOrder();
          break;
        case 'add_custom_content':
          await _clickAddCustomContent();
          break;
        case 'add_location':
          await _clickAddLocation();
          break;
        case 'add_media':
          await _clickAddMedia();
          break;
      }
    });
  }

  void _showTutorialDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => DesktopTutorialPage(),
    );
  }
}
