import 'package:flutter/material.dart';

class ColorConstants {
  static const Color orange = Color(0xFFF2623E);
  static const Color white = Colors.white;
  // static const Color black = Colors.black;
  static const Color blackShade2 = Color(0xFF14141C);
  static const Color black = Color(0xFF121212);
  static const Color red = Color(0xFFED4D3C);

  static const darkBlue = Color(0xFF0D1F44);

  /// color palette colors
  static const purple = Color(0xFF58419C);
  static const green = Color(0xFF6EBCB7); // default color
  static const blue = Color(0xFF3FC0F3);
  static const solidPink = Color(0xFFFF4081);
  static const fadedBrown = Color(0xFFA77D60);
  static const solidRed = Color(0xFFEF5743);
  static const solidPeach = Color(0xFFC47E61);
  static const solidYellow = Color(0xFFCC981A);

  /// color palette for dark mode
  static const darkThemePurple = Color(0xFFBB86FC);
  static const darkThemeGreen = Color(0xFF6EBCB7); // default color
  static const darkThemeBlue = Color(0xFF3FC0F3);
  static const darkThemeSolidPink = Color(0xFFFEB8D5);
  static const darkThemeFadedBrown = Color(0xFFA77D60);
  static const darkThemeSolidRed = Color(0xFFEF5743);
  static const darkThemeSolidPeach = Color(0xFFF2A384);
  static const darkThemeSolidYellow = Color(0xFFFFBE21);

  /// button color
  static const lightThemeDarkGreen = Color(0xFF579591);
  static const lightThemeDarkBlue = Color(0xFF4E8DF1);

  /// Purple Shades
  static const purpleShade1 = Color(0xFFF5F4F9);
  static const purpleShade2 = Color(0xFF58419C);

  static const peachShade1 = Color(0xFFF4F5F7);
  static const peachShade2 = Color(0xFF0E3334);
  static const Color lightPurple = Color(0XFFF5F4F9);
  static const Color lightPurpleText = Color(0xFF9789C2);
  static const Color lightGrey = Color(0xFFF5F4F9);
  static const Color greyText = Color(0xFF98A0B1);
  static const Color darkGrey = Color(0xFF484848);

  /// Opacity color
  static Color dullColor({Color color = Colors.black, double opacity = 0.5}) =>
      color.withOpacity(opacity);

  /// grey shades
  static const Color LIGHT_GREY = Color(0xFFBEC0C8);
  static const Color DARK_GREY = Color(0xFF6D6D79);
  static const Color MILD_GREY = Color(0xFFE4E4E4);
  static const Color FONT_PRIMARY = Color(0xff131219);

  static const Color RED = Color(0xFFe34040);
}

class ContactInitialsColors {
  static Color getColor(String atsign) {
    switch (atsign[1].toUpperCase()) {
      case 'A':
        return Color(0xFFAA0DFE);
      case 'B':
        return Color(0xFF3283FE);
      case 'C':
        return Color(0xFF85660D);
      case 'D':
        return Color(0xFF782AB6);
      case 'E':
        return Color(0xFF565656);
      case 'F':
        return Color(0xFF1C8356);
      case 'G':
        return Color(0xFF16FF32);
      case 'H':
        return Color(0xFFF7E1A0);
      case 'I':
        return Color(0xFFE2E2E2);
      case 'J':
        return Color(0xFF1CBE4F);
      case 'K':
        return Color(0xFFC4451C);
      case 'L':
        return Color(0xFFDEA0FD);
      case 'M':
        return Color(0xFFFE00FA);
      case 'N':
        return Color(0xFF325A9B);
      case 'O':
        return Color(0xFFFEAF16);
      case 'P':
        return Color(0xFFF8A19F);
      case 'Q':
        return Color(0xFF90AD1C);
      case 'R':
        return Color(0xFFF6222E);
      case 'S':
        return Color(0xFF1CFFCE);
      case 'T':
        return Color(0xFF2ED9FF);
      case 'U':
        return Color(0xFFB10DA1);
      case 'V':
        return Color(0xFFC075A6);
      case 'W':
        return Color(0xFFFC1CBF);
      case 'X':
        return Color(0xFFB00068);
      case 'Y':
        return Color(0xFFFBE426);
      case 'Z':
        return Color(0xFFFA0087);
      case '@':
        return Color(0xFFAA0DFE);

      default:
        return Color(0xFFAA0DFE);
    }
  }
}
