import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/event_screen.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/projects_screens/projects_page.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/tasks_screen/task_page.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/Widget/tab_class.dart';
import '../../constants/global_variables.dart';
import '../../features/account/screens/account.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  final int pageIndex;

  const BottomBar({Key? key,  required this.pageIndex}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _page ;
  double bottomBarWidth = 42;
  double bottombarBordersWidth = 5;


  @override
  void initState() {
    super.initState();
     _page = widget.pageIndex;
  }
  List<Widget> pages = [
    const ProjectsPage(),
    const TasksPage(),
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
        backgroundColor: GlobalVariables.backgroundColour,
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
                            : GlobalVariables.backgroundColour,
                        width: bottombarBordersWidth,
                      ))),
              child: const Icon(Icons.home),
            ),
            label: 'Dashboard',
          ),
          //for Project
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 1
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColour,
                width: bottombarBordersWidth,
              ))),
              child: const Icon(Icons.add_task_sharp),
            ),
            label: 'Projects',
          ),
          //for home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 2
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColour,
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
                color: _page == 3
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColour,
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
                color: _page == 4
                    ? GlobalVariables.mainColor
                    : GlobalVariables.backgroundColour,
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
