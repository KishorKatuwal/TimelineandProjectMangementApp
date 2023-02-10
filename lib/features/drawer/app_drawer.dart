import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/chat_screens/group_screen.dart';
import 'package:timelineandprojectmanagementapp/notification/notfication_try.dart';
import '../feedback/screens/feedback_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthService authService = AuthService();

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do want to Log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                authService.logOut(context);
              },
              child: const Text(
                "Yes",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // color: const Color.fromRGBO(242, 244, 255, 1),
      child: Drawer(
        backgroundColor: const Color.fromRGBO(242, 244, 255, 1),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                onTap: () {
                  // Navigator.pushNamed(context, DiscussionScreen.routeName);
                  Navigator.pushNamed(context, GroupScreen.routeName);
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
                height: 105,
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
                leading: Icon(Icons.key),
                title: Text(
                  "Change Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationTryScreen()));
                },
                leading: const Icon(Icons.settings),
                title: const Text(
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
              GestureDetector(
                onTap: () {
                  _showDeleteAlertDialog();
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
