import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopEmptyBasicDetailWidget extends DesktopEmptyWidget {
  DesktopEmptyBasicDetailWidget({
    required VoidCallback onAddDetailsPressed,
  }) : super(
          image: Image.asset(
            Images.basicDetail,
            width: 220,
            height: 215,
          ),
          title: 'Add your Basic details',
          description:
              'Add basic details to start sharing your profile with other',
          buttonTitle: 'Add Details',
          onButtonPressed: onAddDetailsPressed,
        );
}

// class DesktopEmptyBasicDetailWidget extends StatelessWidget {
//   final VoidCallback? onAddDetailsPressed;
//
//   const DesktopEmptyBasicDetailWidget({
//     Key? key,
//     this.onAddDetailsPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final appTheme = AppTheme.of(context);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(
//           Images.basicDetail,
//           width: 220,
//           height: 215,
//         ),
//         SizedBox(height: 16),
//         Text(
//           'Add your Basic details',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: appTheme.primaryTextColor,
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(
//           'Add basic details to start sharing your profile with other',
//           style: TextStyle(
//             fontSize: 16,
//             color: appTheme.secondaryTextColor,
//           ),
//         ),
//         SizedBox(height: 32),
//         ElevatedButton(
//           onPressed: onAddDetailsPressed,
//           child: Text(
//             'Add Details',
//             style: TextStyle(
//               fontSize: 18,
//               color: appTheme.primaryColor,
//             ),
//           ),
//           style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.transparent),
//             elevation: MaterialStateProperty.all<double>(0),
//           ),
//         )
//       ],
//     );
//   }
// }
