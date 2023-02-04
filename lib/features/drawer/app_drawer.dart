import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/screens/discussion.dart';

import '../feedback/screens/feedback_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // color: const Color.fromRGBO(242, 244, 255, 1),
      child: Drawer(
        backgroundColor: const Color.fromRGBO(242, 244, 255, 1),
        child: ListView(
          children: [
            Container(
              color: GlobalVariables.mainColor,
              child: const ListTile(
                title: Text(
                  "Timeline and Project Management App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            const Divider(
              height: 3,
              thickness: 3,
            ),
            const ListTile(
              leading: Icon(Icons.newspaper),
              title: Text(
                "View Exam",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text(
                "View Results",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: Text(
                "View Events",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.assignment_outlined),
              title: Text(
                "View Projects",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Discussion.routeName);
              },
              child: const ListTile(
                leading: Icon(Icons.chat),
                title: Text(
                  "Classroom Discussion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 190,
            ),
            const Divider(
              height: 3,
              thickness: 3,
              color: Colors.black45,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, FeedbackScreen.routeName);
              },
              child: const ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: Text(
                  "Provide Feedback",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                "About App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
