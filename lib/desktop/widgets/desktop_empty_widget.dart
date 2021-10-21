import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopEmptyWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;
  final String buttonTitle;
  final VoidCallback? onButtonPressed;

  const DesktopEmptyWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonTitle,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        image,
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: appTheme.primaryTextColor,
          ),
        ),
        SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: appTheme.secondaryTextColor,
          ),
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: onButtonPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 18,
              color: appTheme.primaryColor,
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            elevation: MaterialStateProperty.all<double>(0),
          ),
        )
      ],
    );
  }
}
