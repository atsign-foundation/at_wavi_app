import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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
                        child:
                            Icon(Icons.search, color: ColorConstants.darkBlue),
                      ),
                      Icon(Icons.more_vert, color: ColorConstants.darkBlue)
                    ],
                  ),
                ),
              ),

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
                      height: 46.toHeight,
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
                      height: 46.toHeight,
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
              SizedBox(height: 20.toHeight),
            ],
          ),
        ),
      ),
    );
  }
}
