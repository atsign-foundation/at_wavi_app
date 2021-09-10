import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'inherited_app_theme.dart';

class AppTheme {
  /// The overall brightness of this color scheme.
  final Brightness brightness;

  /// The color displayed most frequently across your app’s screens and components.
  final Color primaryColor;

  Color get primaryLighterColor => brightness == Brightness.light
      ? primaryColor.withOpacity(0.1)
      : Color(0xFF171717);

  /// An accent color that, when used sparingly, calls attention to parts
  /// of your app.
  final Color secondaryColor;

  Color get accentColor => secondaryColor;

  /// A color that typically appears behind scrollable content.
  final Color backgroundColor;

  final Color primaryTextColor;
  final Color secondaryTextColor;

  final Color separatorColor;
  final Color borderColor;

  bool get isDark => brightness == Brightness.dark;

  /// Create a ColorScheme instance.
  const AppTheme({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.separatorColor,
    required this.borderColor,
  });

  factory AppTheme.from({
    Brightness brightness = Brightness.light,
    Color primaryColor = ColorConstants.desktopPrimaryDefault,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? separatorColor,
    Color? borderColor,
  }) {
    return AppTheme(
      brightness: brightness,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor ?? ColorConstants.desktopSecondary,
      backgroundColor: backgroundColor ??
          (brightness == Brightness.dark
              ? ColorConstants.desktopBackgroundDark
              : ColorConstants.desktopBackgroundLight),
      primaryTextColor: primaryTextColor ??
          (brightness == Brightness.dark
              ? ColorConstants.desktopPrimaryTextDark
              : ColorConstants.desktopPrimaryTextLight),
      secondaryTextColor: secondaryTextColor ??
          (brightness == Brightness.dark
              ? ColorConstants.desktopSecondaryTextDark
              : ColorConstants.desktopSecondaryTextLight),
      separatorColor: separatorColor ??
          (brightness == Brightness.dark
              ? ColorConstants.desktopSeparatorDark
              : ColorConstants.desktopSeparatorLight),
      borderColor: borderColor ??
          (brightness == Brightness.dark
              ? ColorConstants.desktopBorderDark
              : ColorConstants.desktopBorderLight),
    );
  }

  ThemeData toThemeData() {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      accentColor: accentColor,
    );
  }

  static AppTheme of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedAppTheme>()!
        .theme;
  }
}
