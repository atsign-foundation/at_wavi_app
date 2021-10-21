import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_indicator_widget.dart';
import 'package:flutter/material.dart';

class DesktopOnBoardingPage extends StatefulWidget {
  const DesktopOnBoardingPage({Key? key}) : super(key: key);

  @override
  _DesktopOnBoardingPageState createState() => _DesktopOnBoardingPageState();
}

class _DesktopOnBoardingPageState extends State<DesktopOnBoardingPage> {
  late PageController _pageController;

  // int _current = 0;
  // late CarouselController _controller;

  @override
  void initState() {
    _pageController = PageController();
    //   _controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      color: appTheme.primaryLighterColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          // Expanded(
          //   child: CarouselSlider(
          //     items: [
          //       _buildPageWidget(0, appTheme),
          //       _buildPageWidget(1, appTheme),
          //       _buildPageWidget(2, appTheme),
          //     ],
          //     carouselController: _controller,
          //     options: CarouselOptions(
          //         autoPlay: false,
          //         enlargeCenterPage: true,
          //         aspectRatio: 2.0,
          //         onPageChanged: (index, reason) {
          //           setState(() {
          //             _current = index;
          //           });
          //         }),
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children:
          //       Strings.desktop_login_title_page.asMap().entries.map((entry) {
          //     return GestureDetector(
          //       onTap: () => _controller.animateToPage(entry.key),
          //       child: Container(
          //         width: 12.0,
          //         height: 12.0,
          //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: appTheme.primaryTextColor
          //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          //       ),
          //     );
          //   }).toList(),
          // ),
          Expanded(
            child: PageView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 3,
              onPageChanged: (int page) {},
              controller: _pageController,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Visibility(
                          visible: index == 1 || index == 2,
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(
                                index - 1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            borderRadius: BorderRadius.circular(180),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.arrow_back_ios_sharp,
                                size: 24,
                                color: appTheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/images/login${index + 1}.png',
                                  fit: BoxFit.fitHeight,
                                  height: 150,
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                Strings.desktop_login_title_page[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: appTheme.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                Strings.desktop_login_sub_title_page[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                  height: 1.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: index == 0 || index == 1,
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(
                                index + 1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            borderRadius: BorderRadius.circular(180),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 24,
                                color: appTheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: DotsIndicator(
                controller: _pageController,
                itemCount: 3,
                color: appTheme.primaryTextColor,
                onPageSelected: (int page) {
                  _pageController.animateToPage(
                    page,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  _buildPageWidget(int index, AppTheme appTheme) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/login${index + 1}.png',
                fit: BoxFit.fitHeight,
                height: 150,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              Strings.desktop_login_title_page[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: appTheme.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              Strings.desktop_login_sub_title_page[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: appTheme.secondaryTextColor,
                fontWeight: FontWeight.normal,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
