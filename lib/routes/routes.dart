import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/screens/add_link/add_link.dart';
import 'package:at_wavi_app/screens/edit_persona/edit_persona.dart';
import 'package:at_wavi_app/screens/home/home.dart';
import 'package:at_wavi_app/screens/welcome.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  // static String initialRoute = Routes.EDIT_PERSONA;
  static String initialRoute = Routes.WELCOME_SCREEN;
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.WELCOME_SCREEN: (context) => Welcome(),
      Routes.EDIT_PERSONA: (context) => EditPersona(),
      Routes.HOME: (context) => HomeScreen(),
      Routes.ADD_LINK: (context) => AddLink(),
    };
  }

  static Future push(BuildContext context, String value,
      {Object? arguments, Function? callbackAfterNavigation}) {
    return Navigator.of(context)
        .pushNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  // ignore: always_declare_return_types
  static replace(BuildContext context, String value,
      {dynamic arguments, Function? callbackAfterNavigation}) {
    Navigator.of(context)
        .pushReplacementNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  // ignore: always_declare_return_types
  static pushAndRemoveAll(BuildContext context, String value,
      {dynamic arguments, Function? callbackAfterNavigation}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(
      value,
      (_) => false,
      arguments: arguments,
    )
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }
}