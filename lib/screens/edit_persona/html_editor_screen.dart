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
  HtmlEditorController _controller = HtmlEditorController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _value);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _value = widget.initialText; // don't save content
              Navigator.pop(context, _value);
            },
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('HTML'),
        ),
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
                'Save',
                style: CustomTextStyles.customTextStyle(ColorConstants.white,
                    size: 18),
              )),
        ),
        body: SafeArea(
          child: HtmlEditor(
            controller: _controller,
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
              height: 450,
            ),
            callbacks: Callbacks(
                onBeforeCommand: (String? currentHtml) {},
                onChangeContent: (String? changed) {
                  _value = changed;
                },
                onPaste: () {
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   duration: Duration(seconds: 30),
                  //   backgroundColor: ColorConstants.DARK_GREY,
                  //   dismissDirection: DismissDirection.horizontal,
                  //   content: Wrap(
                  //     children: [
                  //       Text(
                  //         // "Paste not allowed here. Use the 'Paste html' button in the previous page.",
                  //         "Use the 'Paste html' button in the previous page to paste html content.",
                  //         style: CustomTextStyles.customTextStyle(
                  //           ColorConstants.white,
                  //           size: 14,
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           _controller.undo();
                  //         },
                  //         child: Text(
                  //           "Undo Paste",
                  //           style: CustomTextStyles.customTextStyle(
                  //             ColorConstants.red,
                  //             size: 16,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ));
                }),
          ),
        ),
      ),
    );
  }
}
