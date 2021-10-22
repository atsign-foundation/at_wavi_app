import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorScreen extends StatefulWidget {
  final String? initialText;
  HtmlEditorScreen({Key? key, this.initialText}) : super(key: key);

  @override
  _HtmlEditorScreenState createState() => _HtmlEditorScreenState();
}

class _HtmlEditorScreenState extends State<HtmlEditorScreen> {
  String? _value;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _value);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          bottomSheet: InkWell(
            onTap: () {
              Navigator.pop(context, _value);
            },
            child: Container(
                alignment: Alignment.center,
                height: 70.toHeight,
                width: SizeConfig().screenWidth,
                color: ColorConstants.black,
                child: Text(
                  'Done',
                  style: CustomTextStyles.customTextStyle(ColorConstants.white,
                      size: 18),
                )),
          ),
          body: HtmlEditor(
            controller: HtmlEditorController(),
            htmlToolbarOptions: HtmlToolbarOptions(
              toolbarType: ToolbarType.nativeGrid,
              dropdownBackgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
            ),
            htmlEditorOptions: HtmlEditorOptions(
              hint: "Your text here...",
              initialText: widget.initialText,
              shouldEnsureVisible: true,
            ),
            otherOptions: OtherOptions(
              height: 500,
            ),
            callbacks: Callbacks(
              onBeforeCommand: (String? currentHtml) {},
              onChangeContent: (String? changed) {
                _value = changed;
              },
            ),
          ),
        ),
      ),
    );
  }
}
