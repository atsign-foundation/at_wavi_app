import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopEmptyAdditionalDetailWidget extends DesktopEmptyWidget {
  DesktopEmptyAdditionalDetailWidget({
    required VoidCallback onAddDetailsPressed,
  }) : super(
          image: Image.asset(
            Images.basicDetail,
            width: 220,
            height: 215,
          ),
          title: 'Add your Additional details',
          description:
              'Add additional details to start sharing your profile with others.',
          buttonTitle: 'Add Details',
          onButtonPressed: onAddDetailsPressed,
        );
}
