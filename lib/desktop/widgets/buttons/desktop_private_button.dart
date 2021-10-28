import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DesktopPublicController extends ValueNotifier<bool> {
  DesktopPublicController({bool isPublic = true}) : super(isPublic);
}

class DesktopPublicButton extends StatelessWidget {
  final DesktopPublicController controller;

  DesktopPublicButton({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Public"),
          value: 1,
        ),
        PopupMenuItem(
          child: Text("Private"),
          value: 2,
        )
      ],
      tooltip: null,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (BuildContext context, bool value, Widget? child) {
          return Icon(
            value ? Icons.public_rounded : Icons.lock_outline_rounded,
            size: 20,
            color: appTheme.secondaryTextColor,
          );
        },
      ),
      onSelected: (index) {
        print(index);
        if (index == 1) {
          controller.value = true;
        } else if (index == 2) {
          controller.value = false;
        }
      },
    );
  }
}
