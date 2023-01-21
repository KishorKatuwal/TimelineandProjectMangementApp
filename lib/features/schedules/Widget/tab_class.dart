import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/screens/schedules.dart';

import '../../../providers/user_provider.dart';

class TabClass extends StatefulWidget {
  const TabClass({Key? key}) : super(key: key);

  @override
  State<TabClass> createState() => _TabClassState();
}

class _TabClassState extends State<TabClass> {
  String formattedDate = DateFormat('E').format(DateTime.now()).toUpperCase();

  @override
  Widget build(BuildContext context) {
    String UserGroup = Provider.of<UserProvider>(context).user.group.trim();
    print(UserGroup);
    return DefaultTabController(
      length: 7,
      initialIndex: formattedDate == "SUN"
          ? 0
          : formattedDate == "MON"
              ? 1
              : formattedDate == "TUE"
                  ? 2
                  : formattedDate == "WED"
                      ? 3
                      : formattedDate == "THU"
                          ? 4
                          : formattedDate == "FRI"
                              ? 5
                              : 6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [GlobalVariables.mainColor, GlobalVariables.mainColor],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: const <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Today Classes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TabBar(
                    indicatorWeight: 4.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.white, width: 4.0),
                        insets: EdgeInsets.only(bottom: 8.0)),
                    unselectedLabelColor: Colors.white60,
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.only(right: 20, left: 20),
                    isScrollable: true,
                    tabs: <Tab>[
                      Tab(text: 'Sunday'),
                      Tab(text: 'Monday'),
                      Tab(text: 'Tuesday'),
                      Tab(text: 'Wednesday'),
                      Tab(text: 'Thursday'),
                      Tab(text: 'Friday'),
                      Tab(text: 'Saturday'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            SchedulesPage(Weekday: "SUN", Group:UserGroup),
            SchedulesPage(Weekday: "MON", Group:UserGroup),
            SchedulesPage(Weekday: "TUE", Group:UserGroup),
            SchedulesPage(Weekday: "WED", Group:UserGroup),
            SchedulesPage(Weekday: "THU", Group:UserGroup),
            SchedulesPage(Weekday: "FRI", Group:UserGroup),
            SchedulesPage(Weekday: "SAT", Group:UserGroup),
          ],
        ),
      ),
    );
  }
}
