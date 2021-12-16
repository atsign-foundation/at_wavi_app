// import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
// import 'package:at_wavi_app/desktop/utils/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// class DesktopVisibilityDetectorWidget extends StatefulWidget {
//   final String keyScreen;
//   final Widget child;
//
//   DesktopVisibilityDetectorWidget({
//     Key? key,
//     required this.keyScreen,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   _DesktopVisibilityDetectorWidgetState createState() =>
//       _DesktopVisibilityDetectorWidgetState();
// }
//
// class _DesktopVisibilityDetectorWidgetState
//     extends State<DesktopVisibilityDetectorWidget> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return VisibilityDetector(
//       key: Key(widget.keyScreen),
//       onVisibilityChanged: (VisibilityInfo info) async {
//         var visiblePercentage = info.visibleFraction * 100;
//         if (visiblePercentage > 50) {
//           await saveStringToSharedPreferences(
//               key: Strings.desktop_current_screen, value: widget.keyScreen);
//         }
//       },
//       child: widget.child,
//     );
//   }
// }