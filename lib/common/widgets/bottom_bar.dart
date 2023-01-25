import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/add_event_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/event_screen.dart';
import 'package:timelineandprojectmanagementapp/tryclass.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/screens/schedules.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/Widget/tab_class.dart';
import '../../constants/global_variables.dart';
import '../../features/account/screens/account.dart';
import '../../features/home/screens/home_screen.dart';
import '../../providers/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottombarBordersWidth = 5;

  List<Widget> pages = [
    // const EventScreen(),
    const EventScreen(),
    const TabClass(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.mainColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //for home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 0
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColor,
                width: bottombarBordersWidth,
              ))),
              child: const Icon(Icons.event_outlined),
            ),
            label: 'Events',
          ),

          //for person
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 1
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColor,
                width: bottombarBordersWidth,
              ))),
              child: const Icon(Icons.menu_book_outlined),
            ),
            label: 'My Classes',
          ),

          //for cart
          BottomNavigationBarItem(

            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 2
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColor,
                width: bottombarBordersWidth,
              ))),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

//from new branch Kishor
