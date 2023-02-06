import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/features/account/widgets/display_details.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account-screen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        size: 100,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Kishor Katuwal",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const DisplayDetails(
                title: "Academic Details",
                completed: "Student's Year",
                completedValue: "Year 1",
                pending: "Student's Faculty",
                pendingValue: "Computing",
                total: "Student's Group",
                totalValue: "C4",
              ),
              const SizedBox(
                height: 20,
              ),
              const DisplayDetails(
                title: "Project Details",
                completed: "Completed Projects",
                completedValue: "5",
                pending: "Pending Projects",
                pendingValue: "10",
                total: "Total Projects",
                totalValue: "15",
              ),
              const SizedBox(
                height: 20,
              ),
              const DisplayDetails(
                title: "Event Details",
                completed: "Completed Events",
                completedValue: "5",
                pending: "Upcoming Events",
                pendingValue: "10",
                total: "Total Events",
                totalValue: "15",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
