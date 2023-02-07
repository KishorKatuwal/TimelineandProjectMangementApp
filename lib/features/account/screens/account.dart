import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/account/screens/edit_user_details.dart';
import 'package:timelineandprojectmanagementapp/features/account/widgets/display_details.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/event_data_model.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/screens/feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';

import '../../../providers/user_provider.dart';
import '../../project_management/models/project_management_model.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account-screen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final EventServices eventServices = EventServices();
  final ProjectServices projectServices = ProjectServices();
  late final int upcomingEvents;
  late final int pendingProjects;

  List<ProjectDataModel> getPendingProj = [];
  List<EventDataModel> getUpcomingEve = [];
  bool finalLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runMethod();
  }

  void runMethod() {
    if (mounted) {
      setState(() {
        getAllData();
      });
    }
  }

  void getAllData() async {
    getPendingProj = await projectServices.getPendingProjects(context);
    getUpcomingEve = await eventServices.getUpcomingEvents(context);
    setState(() {
      finalLoading = false;
      pendingProjects = getPendingProj.length;
      upcomingEvents = getUpcomingEve.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<UserProvider>(context).user.name;
    final email = Provider.of<UserProvider>(context).user.email;
    final group = Provider.of<UserProvider>(context).user.group;
    // final faculty = Provider.of<UserProvider>(context).user.faculty;
    final year = Provider.of<UserProvider>(context).user.year;
    final totalProjects =
        Provider.of<UserProvider>(context).user.projects.length;
    final totalEvents = Provider.of<UserProvider>(context).user.events.length;

    final faculty = context.watch<UserProvider>().user.faculty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        actions: [
          PopupMenuButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onSelected: (value) {
                // Handle the selected value
                if (value == "1") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserDetails(
                                firstName: name,
                                lastName: "noLastName",
                                year: year,
                                group: group,
                                faculty: faculty,
                              )));
                }
              },
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: "1",
                      child: Text("Edit Details"),
                    ),
                  ]),
        ],
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: finalLoading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              size: 60,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            name,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            email,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    DisplayDetails(
                      title: "User Details",
                      completed: "noValue",
                      completedValue: "noValue",
                      pending: "Email",
                      pendingValue: email,
                      total: "User Name",
                      totalValue: name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DisplayDetails(
                      title: "Academic Details",
                      completed: "Student's Year",
                      completedValue: year,
                      pending: "Student's Faculty",
                      pendingValue: faculty,
                      total: "Student's Group",
                      totalValue: group,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DisplayDetails(
                      title: "Project Details",
                      completed: "Completed Projects",
                      completedValue:
                          (totalProjects - pendingProjects).toString(),
                      pending: "Pending Projects",
                      pendingValue: pendingProjects.toString(),
                      total: "Total Projects",
                      totalValue: totalProjects.toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DisplayDetails(
                      title: "Event Details",
                      completed: "Completed Events",
                      completedValue: (totalEvents - upcomingEvents).toString(),
                      pending: "Upcoming Events",
                      pendingValue: upcomingEvents.toString(),
                      total: "Total Events",
                      totalValue: totalEvents.toString(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
