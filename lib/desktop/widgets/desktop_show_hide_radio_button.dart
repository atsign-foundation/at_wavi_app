import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ShowHideController extends ValueNotifier<bool> {
  ShowHideController({bool isShow = true}) : super(isShow);

  bool get isShow => value;
}

class DesktopShowHideRadioButton extends StatelessWidget {
  final ShowHideController controller;
  final ValueChanged<bool>? onChanged;

  const DesktopShowHideRadioButton({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (context, bool value, widget) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: appTheme.secondaryTextColor,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.value = value;
                      onChanged?.call(value);
                    }
                  },
                ),
                Text(
                  'Show',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appTheme.primaryTextColor,
                  ),
                ),
                SizedBox(width: 24),
                Radio<bool>(
                  value: false,
                  groupValue: value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.value = value;
                      onChanged?.call(value);
                    }
                  },
                ),
                Text(
                  'Hide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appTheme.primaryTextColor,
                  ),
                ),
              ],
            )
          ],
        );
      },
      child: Container(),
    );
  }
}
