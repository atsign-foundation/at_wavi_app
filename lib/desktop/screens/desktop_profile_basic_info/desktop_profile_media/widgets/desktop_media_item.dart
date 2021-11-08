import 'package:at_wavi_app/model/user.dart';
import 'package:flutter/material.dart';

class DesktopMediaItem extends StatelessWidget {
  final BasicData data;

  DesktopMediaItem({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.memory(
        data.value,
        fit: BoxFit.cover,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
    );
  }
}
