import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/widgets/desktop_empty_basic_detail_widget.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_welcome_widget.dart';
import 'package:flutter/material.dart';

class DesktopBasicDetailPage extends StatefulWidget {
  const DesktopBasicDetailPage({Key? key}) : super(key: key);

  @override
  _DesktopBasicDetailPageState createState() => _DesktopBasicDetailPageState();
}

class _DesktopBasicDetailPageState extends State<DesktopBasicDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 64),
          DesktopWelcomeWidget(),
          Expanded(
            child: Container(
              child: Center(
                child: DesktopEmptyBasicDetailWidget(
                  onAddDetailsPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
