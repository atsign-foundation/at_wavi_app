import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:flutter/material.dart';

class DesktopMediaPage extends StatefulWidget {
  const DesktopMediaPage({Key? key}) : super(key: key);

  @override
  _DesktopMediaPageState createState() => _DesktopMediaPageState();
}

class _DesktopMediaPageState extends State<DesktopMediaPage>
    with AutomaticKeepAliveClientMixin<DesktopMediaPage> {
  List<String> mediaList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    mediaList.add(
        'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw');
    mediaList.add(
        'https://i.picsum.photos/id/39/300/300.jpg?hmac=HoD3iHGTRG4yexpPUPH8iFp_qzgST0rFI5X7u0JxGOw');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.MEDIA_KEY,
      child: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1.0,
              child: index % 2 != 0
                  ? Image.network(
                      mediaList[index],
                      fit: BoxFit.fitWidth,
                    )
                  : Stack(
                      children: [
                        Image.network(
                          mediaList[index],
                          fit: BoxFit.fitWidth,
                        ),
                        Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 56,
                            color: ColorConstants.white,
                          ),
                        ),
                      ],
                    ),
            );
          },
          itemCount: mediaList.length,
        ),
      ),
    );
  }
}
