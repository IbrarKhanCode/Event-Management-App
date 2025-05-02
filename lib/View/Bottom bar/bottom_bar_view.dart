import 'package:flutter/material.dart';
import 'package:event_management_app/View/community_screen.dart';
import 'package:event_management_app/View/home_screen.dart';
import 'package:event_management_app/View/Profile/profile_screen.dart';
import 'create_event.dart';
import 'message_screen.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOption = [
    HomeScreen(),
    CommunityScreen(),
    CreateEventView(),
    MessageScreen(),
    ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: onItemTapped,
          selectedItemColor: Colors.black,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 0
                        ? 'assets/Group 43 (1).png'
                        : 'assets/Group 43.png',
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 1
                        ? 'assets/Group 18340 (1).png'
                        : 'assets/Group 18340.png',
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                      currentIndex == 2
                          ? 'assets/Group 18528 (1).png'
                          : 'assets/Group 18528.png',
                      width: 22,
                      height: 22),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                      currentIndex == 3
                          ? 'assets/Group 18339 (1).png'
                          : 'assets/Group 18339.png',
                      width: 22,
                      height: 22),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 4
                        ? 'assets/Group 18341 (1).png'
                        : 'assets/Group 18341.png',
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
          ],
        ),
        body: widgetOption[currentIndex]);
  }
}