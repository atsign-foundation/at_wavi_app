import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:flutter/cupertino.dart';

class DesktopBasicItem extends StatelessWidget {
  String title;
  String value;
  Function(String) onValueChanged;

  DesktopBasicItem({
    required this.title,
    required this.value,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: appTheme.secondaryTextColor,
                  fontFamily: 'Inter'),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: DesktopTextField(
              controller: TextEditingController(
                text: value,
              ),
              borderRadius: 10,
              textSize: 14,
              hasUnderlineBorder: false,
              onChanged: (text) {
                onValueChanged(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
