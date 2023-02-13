import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/view_upcomming_events.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/addNewProjectScreen/add_new_project.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/projects_screens/progress_card.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/tasks_screen/task_page.dart';
import '../../../drawer/app_drawer.dart';
import '../../../providers/user_provider.dart';
import '../../event/model/event_data_model.dart';
import 'overview_scroll.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final EventServices eventServices = EventServices();
  List<EventDataModel> upcomingEvents = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).user.firstName;
    return Scaffold(
      key: _scaffoldKey,
      drawer:  AppDrawer(),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(242, 244, 255, 1),
            padding: const EdgeInsets.all(0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        // color: Color.fromARGB(255, 123, 0, 245),
                        color: GlobalVariables.mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNewTask()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Hello,",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          TextSpan(
                            text: userName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "Stay on schedule, stay on track with our app.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 0),
                child: OverView(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upcoming Events",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 180,
                      child: FutureBuilder(
                        future: eventServices.getUpcomingEvents(context),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text("An error occurred: ${snapshot.error}"),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data.isEmpty) {
                            return const Center(
                              child: Text("No Events are added"),
                            );
                          } else {
                            upcomingEvents = snapshot.data;
                            return ListView.builder(
                                itemCount: upcomingEvents.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  String date1 =
                                      upcomingEvents[index].EventDate;
                                  DateTime date2 = DateTime.now();
                                  Duration difference =
                                      DateTime.parse(date1).difference(date2);
                                  return ViewUpcomingEvents(
                                      eventName:
                                          upcomingEvents[index].EventName,
                                      eventSubject:
                                          upcomingEvents[index].EventType,
                                      remainingDays: difference.inDays);
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
