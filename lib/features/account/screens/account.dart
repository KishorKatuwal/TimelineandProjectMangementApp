import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/features/account/screens/edit_user_details.dart';
import 'package:timelineandprojectmanagementapp/features/account/widgets/display_details.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_controller.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';

class AccountScreen extends ConsumerStatefulWidget {
  static const String routeName = '/account-screen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  final EventServices eventServices = EventServices();
  final ProjectServices projectServices = ProjectServices();

  // late final int upcomingEvents;
  // late final int pendingProjects;
  //
  // List<ProjectDataModel> getPendingProj = [];
  // List<EventDataModel> getUpcomingEve = [];
  bool finalLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //runMethod();
  }

  // mounted ensured that widget is currently active and mounted in the widget tree.
  // void runMethod() {
  //   if (mounted) {
  //     setState(() {
  //       getAllData();
  //     });
  //   }
  // }
  //
  // //getting data from the backend
  // void getAllData() async {
  //   setState(() {
  //     finalLoading = true;
  //   });
  //   getPendingProj =
  //       await projectServices.getPendingProjects(ref: ref, context: context);
  //   getUpcomingEve = await eventServices.getUpcomingEvents(context);
  //   setState(() {
  //     finalLoading = false;
  //     pendingProjects = getPendingProj.length;
  //     upcomingEvents = getUpcomingEve.length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
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
              // value is coming from popup menu item
              if (value == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserDetails(
                      firstName: user!.firstName,
                      lastName: user.lastName,
                      year: user.year,
                      group: user.group,
                      faculty: user.faculty,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "1",
                child: Text("Edit Details"),
              ),
            ],
          ),
        ],
        centerTitle: true,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //display details is imported from display details class inside widget folder
                    DisplayDetails(
                      title: "User Details",
                      completed: "Email",
                      completedValue: user!.email,
                      pending: "Last Name",
                      pendingValue: user.lastName,
                      total: "First Name",
                      totalValue: user.firstName,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DisplayDetails(
                      title: "Academic Details",
                      completed: "Student's Year",
                      completedValue: user.year,
                      pending: "Student's Faculty",
                      pendingValue: user.faculty,
                      total: "Student's Group",
                      totalValue: user.group,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // DisplayDetails(
                    //   title: "Project Details",
                    //   completed: "Completed Projects",
                    //   completedValue:
                    //       (user.projects.length - pendingProjects).toString(),
                    //   pending: "Pending Projects",
                    //   pendingValue: pendingProjects.toString(),
                    //   total: "Total Projects",
                    //   totalValue: user.projects.length.toString(),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // DisplayDetails(
                    //   title: "Event Details",
                    //   completed: "Completed Events",
                    //   completedValue:
                    //       (user.events.length - upcomingEvents).toString(),
                    //   pending: "Upcoming Events",
                    //   pendingValue: upcomingEvents.toString(),
                    //   total: "Total Events",
                    //   totalValue: user.events.length.toString(),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
