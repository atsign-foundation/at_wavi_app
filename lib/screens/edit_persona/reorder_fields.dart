import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ReorderFields extends StatefulWidget {
  final AtCategory category;
  ReorderFields({required this.category});

  @override
  _ReorderFieldsState createState() => _ReorderFieldsState();
}

class _ReorderFieldsState extends State<ReorderFields> {
  var fields = <String>[];

  @override
  void initState() {
    if (FieldOrderService().previewOrders[widget.category.name] != null) {
      fields = FieldOrderService().previewOrders[widget.category.name]!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: 500,
            child: ReorderableListView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                for (int index = 0; index < fields.length; index++)
                  ListTile(
                    key: Key('$index'),
                    title: Text('Item ${fields[index]}'),
                  )
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final String item = fields.removeAt(oldIndex);
                  fields.insert(newIndex, item);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  getRowTitle() {
    for (int index = 0; index < fields.length; index++)
      ListTile(
        key: Key('$index'),
        title: Text('Item ${fields[index]}'),
      );
  }
}
