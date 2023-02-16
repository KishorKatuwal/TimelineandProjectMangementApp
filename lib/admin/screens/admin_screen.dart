import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/screens/admin_feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';

  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService authService = AuthService();

  void _showLogoutAlertDialog() {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Screen"),
      ),
      body: GridView.count(
          padding: const EdgeInsets.all(15),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Users",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AdminFeedbackScreen.routeName);
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.feedback_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Feedback",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                _showLogoutAlertDialog();
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
          ]),
    );
  }
}
