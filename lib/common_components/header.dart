import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget? leading, trailing, centerWidget;
  Header({this.leading, this.trailing, this.centerWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          (leading != null)
              ? Expanded(
                  child: Align(alignment: Alignment.topLeft, child: leading!))
              : Expanded(child: SizedBox()),
          (centerWidget != null)
              ? Expanded(
                  child:
                      Align(alignment: Alignment.center, child: centerWidget!))
              : Expanded(child: SizedBox()),
          (trailing != null)
              ? Expanded(
                  child: Align(alignment: Alignment.topRight, child: trailing!))
              : Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
