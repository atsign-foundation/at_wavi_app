import 'package:at_wavi_app/desktop/screens/desktop_home/desktop_home_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_login/desktop_login_landing_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile/desktop_profile_page.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desktop_route_names.dart';

class DesktopSetupRoutes {
  static String initialRoute = DesktopRoutes.DESKTOP_LOGIN;

  // static String initialRoute = DesktopRoutes.DESKTOP_WELCOME;
  static var _provider = Provider.of<NestedRouteProvider>(
      NavService.navKey.currentContext!,
      listen: false);

  static Map<String, WidgetBuilder> get routes {
    return {
      DesktopRoutes.DESKTOP_HOME: (context) =>
          DesktopHomePage(key: UniqueKey()),
      DesktopRoutes.DESKTOP_PROFILE: (context) =>
          DesktopProfilePage(key: UniqueKey()),
      DesktopRoutes.DESKTOP_LOGIN: (context) =>
          DesktopLoginLandingPage(key: UniqueKey()),
    };
  }

  static Map<String, WidgetBuilder> routeBuilders(
      BuildContext context, RouteSettings routeSettings) {
    return {
      DesktopRoutes.DESKTOP_HOME: (context) => DesktopHomePage(),
      DesktopRoutes.DESKTOP_PROFILE: (context) => DesktopProfilePage(),
      DesktopRoutes.DESKTOP_LOGIN: (context) => DesktopLoginLandingPage(),
    };
  }
}

class NestedRouteProvider extends BaseModel {
  String Routes = 'routes';

  NestedRouteProvider();

  String current_route = "";

  init() {
    setStatus(Routes, Status.Done);
  }

  update(String value) {
    current_route = value;
    setStatus(Routes, Status.Done);
  }
}
