import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_controller.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/screens/schedules.dart';

class TabClass extends ConsumerStatefulWidget {
  const TabClass({Key? key}) : super(key: key);

  @override
  ConsumerState<TabClass> createState() => _TabClassState();
}

class _TabClassState extends ConsumerState<TabClass> {
  //getting current week day
  String formattedDate = DateFormat('E').format(DateTime.now()).toUpperCase();

  @override
  Widget build(BuildContext context) {
    //getting user group
    String userGroup = ref.watch(userProvider)!.group;
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
              color: GlobalVariables.mainColor,
            ),
            child: const SafeArea(
              child: Column(
                children: [
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
        body: TabBarView(
          children: [
            SchedulesPage(Weekday: "SUN", Group: userGroup),
            SchedulesPage(Weekday: "MON", Group: userGroup),
            SchedulesPage(Weekday: "TUE", Group: userGroup),
            SchedulesPage(Weekday: "WED", Group: userGroup),
            SchedulesPage(Weekday: "THU", Group: userGroup),
            SchedulesPage(Weekday: "FRI", Group: userGroup),
            SchedulesPage(Weekday: "SAT", Group: userGroup),
          ],
        ),
      ),
    );
  }
}
