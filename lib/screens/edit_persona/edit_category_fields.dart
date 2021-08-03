import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/material.dart';

class EditCategoryFields extends StatefulWidget {
  final AtCategory category;
  EditCategoryFields({required this.category});

  @override
  _EditCategoryFieldsState createState() => _EditCategoryFieldsState();
}

class _EditCategoryFieldsState extends State<EditCategoryFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // heading
          // loop through the fields in slidable
          // add custom button
        ],
      ),
    );
  }
}
