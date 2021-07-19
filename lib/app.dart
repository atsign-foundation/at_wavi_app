import 'package:at_wavi_app/screens/edit_persona/edit_persona.dart';
import 'package:at_wavi_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AtSign wavi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: EditPersona(),
    );
  }
}
