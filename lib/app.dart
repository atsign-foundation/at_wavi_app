import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/follow_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/theme.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
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
      theme: Themes.lightTheme(ColorConstants.purple),
      routes: SetupRoutes.routes,
    );
  }
}
