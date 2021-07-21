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
              ? Container(child: Expanded(child: leading!))
              : Expanded(child: SizedBox()),
          (centerWidget != null)
              ? Expanded(child: centerWidget!)
              : Expanded(child: SizedBox()),
          (trailing != null)
              ? Expanded(child: trailing!)
              : Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
