import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/screens/add_link/add_link.dart';
import 'package:at_wavi_app/screens/add_link/create_custom_add_link/create_custom_add_link.dart';
import 'package:at_wavi_app/screens/edit_persona/edit_persona.dart';
import 'package:at_wavi_app/screens/following.dart';
import 'package:at_wavi_app/screens/home/home.dart';
import 'package:at_wavi_app/screens/search.dart';
import 'package:at_wavi_app/screens/welcome.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  static String initialRoute = Routes.WELCOME_SCREEN;
  // static String initialRoute = Routes.ADD_LINK;
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.WELCOME_SCREEN: (context) => Welcome(),
      Routes.EDIT_PERSONA: (context) => EditPersona(),
      Routes.HOME: (context) {
        if ((ModalRoute.of(context) != null) &&
            (ModalRoute.of(context)!.settings.arguments != null)) {
          Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return HomeScreen(
            themeData: args['themeData'],
            isPreview: args['isPreview'],
          );
        }

        return HomeScreen();
      },
      Routes.ADD_LINK: (context) {
        if ((ModalRoute.of(context) != null) &&
            (ModalRoute.of(context)!.settings.arguments != null)) {
          Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return AddLink(args['url']);
        }
        return AddLink('');
      },
      Routes.FOLLOWING_SCREEN: (context) => Following(),
      Routes.SEARCH_SCREEN: (context) => Search(),
      Routes.CREATE_CUSTOM_ADD_LINK: (context) {
        if ((ModalRoute.of(context) != null) &&
            (ModalRoute.of(context)!.settings.arguments != null)) {
          Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return CreateCustomAddLink(args['value'], category: args['category']);
        }

        return CreateCustomAddLink('', category: AtCategory.DETAILS);
      },
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
