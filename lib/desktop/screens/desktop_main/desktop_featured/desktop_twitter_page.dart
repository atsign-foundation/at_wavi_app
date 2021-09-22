import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopTwitterPage extends StatefulWidget {
  const DesktopTwitterPage({Key? key}) : super(key: key);

  @override
  _DesktopTwitterPageState createState() => _DesktopTwitterPageState();
}

class _DesktopTwitterPageState extends State<DesktopTwitterPage>
    with AutomaticKeepAliveClientMixin<DesktopTwitterPage> {
  @override
  bool get wantKeepAlive => true;

  List<String> twitterPosts = [];

  @override
  void initState() {
    twitterPosts.add(
        'A convenience widget that combines common painting, positioning, and sizing widgets.');
    twitterPosts.add(
        'A container first surrounds the child with padding (inflated by any borders present in the decoration) and then applies additional constraints to the padded extent');
    twitterPosts.add(
        'During painting, the container first applies the given transform, then paints the decoration to fill the padded extent, then it paints the child, and finally paints the foregroundDecoration, also filling the padded extent.');
    twitterPosts.add(
        'Containers with no children try to be as big as possible unless the incoming constraints are unbounded, in which case they try to be as small as possible.');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: AtCategory.TWITTER.name,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorConstants.LIGHT_GREY,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: twitterPosts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        twitterPosts[index],
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme.primaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '15 mins ago',
                        style: TextStyle(
                            fontSize: 10,
                            color: appTheme.secondaryTextColor,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: appTheme.borderColor,
                );
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
