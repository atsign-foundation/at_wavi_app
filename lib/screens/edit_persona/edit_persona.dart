import 'dart:convert';

import 'package:at_wavi_app/common_components/provider_callback.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/screens/edit_persona/content_edit.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPersona extends StatefulWidget {
  const EditPersona({Key? key}) : super(key: key);

  @override
  _EditPersonaState createState() => _EditPersonaState();
}

class _EditPersonaState extends State<EditPersona>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ThemeColor _themeColor;
  List<Color> _colors = [
    ColorConstants.purple,
    ColorConstants.green,
    ColorConstants.blue,
    ColorConstants.darkThemeSolidPink,
    ColorConstants.fadedBrown,
    ColorConstants.solidRed,
    ColorConstants.darkThemeSolidPeach,
    ColorConstants.darkThemeSolidYellow,
  ];

  ThemeData? _themeData;

  late ThemeColor _theme;
  late Color _highlightColor;
  bool _updateTheme = false,
      _updateHighlightColor = false; // used to track if to update new values
  late TabController _controller;
  int _tabIndex = 0;

  @override
  void initState() {
    _getThemeData();

    _controller =
        TabController(length: 2, vsync: this, initialIndex: _tabIndex);
    FieldOrderService().setPreviewOrder = {...FieldOrderService().fieldOrders};
    var userJson =
        User.toJson(Provider.of<UserProvider>(context, listen: false).user!);
    User previewUser = User.fromJson(json.decode(json.encode(userJson)));
    Provider.of<UserPreview>(context, listen: false).setUser = previewUser;
    super.initState();
  }

  _getThemeData() async {
    _themeData =
        await Provider.of<ThemeProvider>(context, listen: false).getTheme();
    _theme = _themeData!.brightness == Brightness.dark
        ? ThemeColor.Dark
        : ThemeColor.Light;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      return CircularProgressIndicator();
    }

    _themeColor = Provider.of<ThemeProvider>(context, listen: false).themeColor;

    return Container(
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            bottomSheet: _bottomSheet(),
            backgroundColor: _themeData!.scaffoldBackgroundColor,
            appBar: AppBar(
              iconTheme: IconThemeData(color: _themeData!.primaryColor),
              toolbarHeight: 55,
              title: Text(
                'Edit Persona',
                style: CustomTextStyles.customBoldTextStyle(
                    _themeData!.primaryColor,
                    size: 16),
              ),
              centerTitle: false,
              backgroundColor: _themeData!.scaffoldBackgroundColor,
              elevation: 0,
              // ),
              // centerTitle: false,
              // backgroundColor: _themeData!.scaffoldBackgroundColor,
              // elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.toHeight),
                    TabBar(
                      onTap: (index) async {},
                      labelColor: _themeData!.primaryColor,
                      indicatorWeight: 5.toHeight,
                      indicatorColor: ColorConstants.green,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor:
                          _themeData!.primaryColor.withOpacity(0.5),
                      controller: _controller,
                      tabs: [
                        Text(
                          'Content',
                          style: TextStyle(
                              letterSpacing: 0.1, fontSize: 18.toFont),
                        ),
                        Text(
                          'Appearance',
                          style: TextStyle(
                              letterSpacing: 0.1, fontSize: 18.toFont),
                        )
                      ],
                    ),
                    Divider(height: 1),
                    Expanded(
                        child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      controller: _controller,
                      children: [
                        CotentEdit(
                          themeData: _themeData!,
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Theme',
                                style: CustomTextStyles.customBoldTextStyle(
                                    _themeData!.primaryColor,
                                    size: 18),
                              ),
                              SizedBox(height: 15.toHeight),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      _themeCard(),
                                      SizedBox(height: 13.toHeight),
                                      Text(
                                        'Light',
                                        style: CustomTextStyles.black(size: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      _themeCard(isDark: true),
                                      SizedBox(height: 13.toHeight),
                                      Text(
                                        'Dark',
                                        style: CustomTextStyles.black(size: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.toHeight),
                              Text(
                                'Colour',
                                style: CustomTextStyles.customBoldTextStyle(
                                    _themeData!.primaryColor,
                                    size: 18),
                              ),
                              SizedBox(height: 15.toHeight),
                              Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                runSpacing: 10.0,
                                spacing: 10.0,
                                children: _colors.map((_color) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _highlightColor = _color;
                                        _updateHighlightColor = true;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        _rectangle(
                                            width: 78.toWidth,
                                            height: 78.toWidth,
                                            color: _color,
                                            roundedCorner: 10),
                                        (_updateHighlightColor
                                                ? (_color == _highlightColor)
                                                : isColorSelected(_color))
                                            ? Positioned(
                                                child: _circularDoneIcon(
                                                    isDark: true,
                                                    size: 35.toWidth))
                                            : SizedBox()
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                  height: 80.toHeight +
                                      10.toHeight), // bottomsheet height
                            ],
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  bool isColorSelected(Color _color) {
    var highlightColor =
        Provider.of<ThemeProvider>(context, listen: false).highlightColor;

    if ([ColorConstants.purple, ColorConstants.darkThemePurple]
                .indexOf(_color) >
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.green, ColorConstants.darkThemeGreen]
                .indexOf(highlightColor!) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.blue, ColorConstants.darkThemeBlue]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.solidPink, ColorConstants.darkThemeSolidPink]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.fadedBrown, ColorConstants.darkThemeFadedBrown]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.solidRed, ColorConstants.darkThemeSolidRed]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.solidPeach, ColorConstants.darkThemeSolidPeach]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else if ([ColorConstants.solidYellow, ColorConstants.darkThemeSolidYellow]
                .indexOf(highlightColor) !=
            -1 &&
        _color == highlightColor) {
      return true;
    } else
      return false;
  }

  Widget _bottomSheet() {
    return Row(
      children: [
        _bottomSheetButton('Preview'),
        _bottomSheetButton('Save & Publish', isDark: true),
      ],
    );
  }

  Widget _bottomSheetButton(String _text, {bool isDark = false}) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (_text == 'Preview') {
            await _previewButtonCall();
          }

          if (_text == 'Save & Publish') {
            await _saveButtonCall();
          }
        },
        child: Container(
          height: 80.toHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isDark
                  ? _themeData!.primaryColor
                  : _themeData!.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3.0,
                ),
              ]),
          child: Text(
            _text,
            style: isDark
                ? CustomTextStyles.customTextStyle(
                    _themeData!.scaffoldBackgroundColor,
                    size: 18)
                : CustomTextStyles.customTextStyle(_themeData!.primaryColor,
                    size: 18),
          ),
        ),
      ),
    );
  }

  Widget _themeCard({bool isDark = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          _theme = isDark ? ThemeColor.Dark : ThemeColor.Light;
          _updateTheme = true;
        });

        // Provider.of<ThemeProvider>(context, listen: false)
        //     .setTheme(isDark ? ThemeColor.Dark : ThemeColor.Light);
      },
      child: Container(
        width: 166.toWidth,
        height: 200.toHeight,
        decoration: BoxDecoration(
            color: isDark ? ColorConstants.black : ColorConstants.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ]),
        padding: EdgeInsets.fromLTRB(
            10.toWidth, 11.toHeight, 10.toWidth, 11.toHeight),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _rectangle(
                  color: isDark
                      ? ColorConstants.peachShade2
                      : ColorConstants.peachShade1,
                  opacity: isDark ? 0.3 : 1,
                ),
                SizedBox(
                  height: 16.toHeight,
                ),
                _rectangle(
                  color: isDark
                      ? ColorConstants.peachShade2
                      : ColorConstants.peachShade1,
                  opacity: isDark ? 0.3 : 1,
                ),
                SizedBox(
                  height: 13.toHeight,
                ),
                _button(),
              ],
            ),
            (_updateTheme
                    ? (_theme == (isDark ? ThemeColor.Dark : ThemeColor.Light))
                    : (_themeColor ==
                        (isDark ? ThemeColor.Dark : ThemeColor.Light)))
                ? Positioned(child: _circularDoneIcon(isDark: isDark))
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _rectangle(
      {double? width,
      double? height,
      Color? color,
      double? opacity,
      double? roundedCorner}) {
    return Opacity(
      opacity: opacity ?? 1,
      child: Container(
        width: width ?? 150.toWidth,
        height: height ?? 50.toHeight,
        decoration: BoxDecoration(
          color: color ?? ColorConstants.peachShade1,
          borderRadius: BorderRadius.circular(roundedCorner ?? 5),
        ),
      ),
    );
  }

  Widget _button() {
    return Container(
      width: 112.toWidth,
      height: 45.toHeight,
      decoration: BoxDecoration(
        color: ColorConstants.green,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _circularDoneIcon({bool isDark = false, double? size}) {
    return Container(
      width: size ?? 40.toWidth,
      height: size ?? 40.toWidth,
      decoration: BoxDecoration(
        color: isDark ? ColorConstants.white : ColorConstants.black,
        borderRadius: BorderRadius.circular(35.toHeight),
      ),
      child: Icon(
        Icons.done,
        color: isDark ? ColorConstants.black : ColorConstants.white,
        size: 30.toFont,
      ),
    );
  }

  _previewButtonCall() async {
    var _modifiedTheme =
        await Provider.of<ThemeProvider>(context, listen: false).getTheme();

    var _modifiedHighlightColor =
        Provider.of<ThemeProvider>(context, listen: false).highlightColor;

    if (_updateHighlightColor) {
      _modifiedHighlightColor = _highlightColor;
    }

    // converting highlight color according to light/dark theme
    _modifiedHighlightColor = _theme == ThemeColor.Dark
        ? Provider.of<ThemeProvider>(context, listen: false)
            .convertHighlightColorForDarktheme(_modifiedHighlightColor!)
        : Provider.of<ThemeProvider>(context, listen: false)
            .convertHighlightColorForLighttheme(_modifiedHighlightColor!);

    if (_updateTheme) {
      _modifiedTheme = _theme == ThemeColor.Dark
          ? Themes.darkTheme(highlightColor: _modifiedHighlightColor)
          : Themes.lightTheme(highlightColor: _modifiedHighlightColor);
    } else {
      _modifiedTheme =
          Provider.of<ThemeProvider>(context, listen: false).themeColor ==
                  ThemeColor.Dark
              ? Themes.darkTheme(highlightColor: _modifiedHighlightColor)
              : Themes.lightTheme(highlightColor: _modifiedHighlightColor);
    }

    await SetupRoutes.push(context, Routes.HOME, arguments: {
      'themeData': _modifiedTheme,
      'isPreview': true,
    });
  }

  _saveButtonCall() async {
    /// Changes theme
    await _publishButtonCall();
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
        await SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
      },
    );
  }

  _publishButtonCall() async {
    if (_updateTheme) {
      await providerCallback<ThemeProvider>(
        context,
        task: (provider) async {
          await provider.setTheme(themeColor: _theme);
        },
        onError: (provider) {
          ScaffoldMessenger.of(scaffoldKey.currentContext!)
              .showSnackBar(SnackBar(
            backgroundColor: ColorConstants.RED,
            content: Text(
              'Publishing theme failed. Try again!',
              style: CustomTextStyles.customTextStyle(
                ColorConstants.white,
              ),
            ),
          ));
        },
        showDialog: false,
        text: 'Publishing theme',
        taskName: (provider) => provider.SET_THEME,
        onSuccess: (provider) async {},
      );
    }

    if (_updateHighlightColor) {
      await providerCallback<ThemeProvider>(
        context,
        task: (provider) async {
          await provider.setTheme(highlightColor: _highlightColor);
        },
        onError: (provider) {
          ScaffoldMessenger.of(scaffoldKey.currentContext!)
              .showSnackBar(SnackBar(
            backgroundColor: ColorConstants.RED,
            content: Text(
              'Publishing theme color failed. Try again!',
              style: CustomTextStyles.customTextStyle(
                ColorConstants.white,
              ),
            ),
          ));
        },
        showDialog: false,
        text: 'Publishing color',
        taskName: (provider) => provider.SET_THEME,
        onSuccess: (provider) async {},
      );
    }
  }
}
