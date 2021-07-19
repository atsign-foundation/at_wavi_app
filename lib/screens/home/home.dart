import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/screens/home/widgets/home_channel.dart';
import 'package:at_wavi_app/screens/home/widgets/home_details.dart';
import 'package:at_wavi_app/screens/home/widgets/home_empty_details.dart';
import 'package:at_wavi_app/screens/home/widgets/home_featured.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

enum HOME_TABS { DETAILS, CHANNELS, FEATURED }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  HOME_TABS _currentTab = HOME_TABS.DETAILS;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.orange,
        onTap: _onItemTapped,
        // elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // header
                Header(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 18.toFont,
                          color: ColorConstants.darkBlue,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.search,
                              color: ColorConstants.darkBlue),
                        ),
                        Icon(Icons.more_vert, color: ColorConstants.darkBlue)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.toHeight),

                // content
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 116.toWidth,
                      height: 116.toHeight,
                      child: Icon(Icons.person),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Lauren London',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.purple,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 8.toHeight),
                          Text(
                            '@lauren',
                            style: TextStyle(
                                color: ColorConstants.orange,
                                fontSize: 18.toFont),
                          ),
                          SizedBox(height: 18.5.toHeight),
                          Divider(),
                          SizedBox(height: 18.5.toHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '0 Followers',
                                  style: TextStyle(
                                      fontSize: 14.toFont,
                                      color: ColorConstants.purple),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text('0 Following',
                                    style: TextStyle(
                                        fontSize: 14.toFont,
                                        color: ColorConstants.purple)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.toHeight),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 55.toHeight,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF5F4F9)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 16.toFont,
                                color: ColorConstants.purple),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 55.toHeight,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF5F4F9)),
                          ),
                          onPressed: () {},
                          child: Text('Share Profile',
                              style: TextStyle(
                                  fontSize: 16.toFont,
                                  color: ColorConstants.purple)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25.toHeight),

                Container(
                  height: 70.toHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.lightGrey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _currentTab = HOME_TABS.DETAILS;
                            });
                          },
                          child: tab('Details', HOME_TABS.DETAILS),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentTab = HOME_TABS.CHANNELS;
                              });
                            },
                            child: tab('Channels', HOME_TABS.CHANNELS)),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _currentTab = HOME_TABS.FEATURED;
                            });
                          },
                          child: tab('Featured', HOME_TABS.FEATURED),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.toHeight),
                homeContent()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tab(String title, HOME_TABS tab) {
    return Container(
      decoration: BoxDecoration(
        color: _currentTab == tab ? ColorConstants.purple : Colors.white,
        border: _currentTab == tab
            ? Border.all(color: ColorConstants.lightGrey)
            : null,
        borderRadius: _currentTab == tab ? BorderRadius.circular(60) : null,
      ),
      child: Center(
          child: Text(title,
              style: TextStyle(
                  color:
                      _currentTab == tab ? Colors.white : ColorConstants.purple,
                  fontSize: 18.toFont))),
    );
  }

  Widget homeContent() {
    if (_currentTab == HOME_TABS.DETAILS) {
      // return HomeEmptyDetails();
      return HomeDetails();
    } else if (_currentTab == HOME_TABS.DETAILS) {
      return HomeChannels();
    } else if (_currentTab == HOME_TABS.DETAILS) {
      return HomeFeatured();
    } else
      return SizedBox();
  }
}
