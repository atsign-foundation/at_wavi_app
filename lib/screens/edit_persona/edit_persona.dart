import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/services/theme_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPersona extends StatefulWidget {
  const EditPersona({Key? key}) : super(key: key);

  @override
  _EditPersonaState createState() => _EditPersonaState();
}

class _EditPersonaState extends State<EditPersona> {
  late ThemeColor _themeColor;
  List<Color> _colors = [
    ColorConstants.purple,
    ColorConstants.peach,
    ColorConstants.blue,
    ColorConstants.solidPink,
    ColorConstants.fadedBrown,
    ColorConstants.solidOrange,
    ColorConstants.solidLightGreen,
    ColorConstants.solidYellow,
  ];

  late ThemeColor _theme;
  late Color _highlightColor;
  bool _updateTheme = false, _updateHighlightColor = false;

  // ThemeService()
  //       .getThemePreference('@new52plum', returnHighlightColorPreference: true);

  @override
  void initState() {
    _theme = Provider.of<ThemeProvider>(context, listen: false).getTheme;
    _highlightColor = Themes.highlightColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _themeColor = Provider.of<ThemeProvider>(context, listen: false).getTheme;

    return Scaffold(
        bottomSheet: _bottomSheet(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'Edit Persona',
            style: CustomTextStyles.customBoldTextStyle(
                Theme.of(context).primaryColor,
                size: 16),
          ),
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.toHeight),
              Text(
                'Theme',
                style: CustomTextStyles.customBoldTextStyle(
                    Theme.of(context).primaryColor,
                    size: 18),
              ),
              SizedBox(height: 15.toHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Theme.of(context).primaryColor,
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
                            width: 78,
                            height: 78,
                            color: _color,
                            roundedCorner: 10),
                        (_updateHighlightColor
                                ? (_color == _highlightColor)
                                : (_color == Themes.highlightColor))
                            ? Positioned(
                                child: _circularDoneIcon(
                                    isDark: true, size: 35.toWidth))
                            : SizedBox()
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }

  Widget _bottomSheet() {
    return Row(
      children: [
        _bottomSheetButton('Preview'),
        _bottomSheetButton('Save'),
        _bottomSheetButton('Publish', isDark: true),
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

          if (_text == 'Save') {
            await _saveButtonCall();
          }

          if (_text == 'Publish') {
            await _publishButtonCall();
          }

          await SetupRoutes.push(context, Routes.HOME);
        },
        child: Container(
          height: 80.toHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
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
                    Theme.of(context).scaffoldBackgroundColor,
                    size: 18)
                : CustomTextStyles.customTextStyle(
                    Theme.of(context).primaryColor,
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
        height: 166.toWidth,
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
        padding: EdgeInsets.fromLTRB(10, 11, 10, 11),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                _rectangle(
                  color: isDark
                      ? ColorConstants.purpleShade2
                      : ColorConstants.purpleShade1,
                  opacity: isDark ? 0.3 : 1,
                ),
                SizedBox(
                  height: 16.toHeight,
                ),
                _rectangle(
                  color: isDark
                      ? ColorConstants.purpleShade2
                      : ColorConstants.purpleShade1,
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
          color: color ?? ColorConstants.purpleShade1,
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
        color: ColorConstants.purpleShade2,
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

  _previewButtonCall() async {}

  _saveButtonCall() async {}

  _publishButtonCall() async {
    if (_updateHighlightColor) {
      Provider.of<ThemeProvider>(context, listen: false)
          .setTheme(highlightColor: _highlightColor);
    }

    if (_updateTheme) {
      Provider.of<ThemeProvider>(context, listen: false)
          .setTheme(themeColor: _theme, highlightColor: _highlightColor);
    }
  }
}
