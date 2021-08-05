import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/at_key_set_service.dart';
import 'package:at_wavi_app/services/follow_service.dart';
import 'package:at_wavi_app/screens/options.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()),
      ChangeNotifierProvider<FollowService>(
          create: (context) => FollowService()),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<SetPrivateState>(
          create: (context) => SetPrivateState()),
      ChangeNotifierProvider<AtKeySetService>(
          create: (context) => AtKeySetService()),
    ], child: MaterialAppClass());
  }
}

class MaterialAppClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      title: 'AtSign wavi',
      debugShowCheckedModeBanner: false,
      initialRoute: SetupRoutes.initialRoute,
      navigatorKey: NavService.navKey,
      theme: Themes.lightTheme(Colors.transparent),
      routes: SetupRoutes.routes,
    );
  }
}
