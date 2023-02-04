import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';
import '../tasks_screen/task_detail.dart';
import 'overview_card.dart';

class OverView extends StatefulWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> with TickerProviderStateMixin {
  late TabController tabController;
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectDataModel = [];
  List<ProjectDataModel> completedProjects = [];
  List<ProjectDataModel> pendingProjects = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(0),
            unselectedLabelColor: Colors.grey.shade400,
            tabs: const [
              Tab(
                text: "Pending Projects",
              ),
              Tab(
                text: "Completed Projects",
              ),
              Tab(
                text: "All Projects",
              ),
            ],
          ),
          SizedBox(
            height: 250,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                FutureBuilder(
                  future: projectServices.getPendingProjects(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("An error occurred: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return const Center(
                        child: Text("No Pending Projects!"),
                      );
                    } else {
                      pendingProjects = snapshot.data;
                      return ListView.builder(
                          itemCount: pendingProjects.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            List<Task> tasks = pendingProjects[index].tasks;
                            int count = 0;
                            for (int i = 0; i < tasks.length; i++) {
                              if (tasks[i].status == false) {
                                count = count + 1;
                              }
                            }
                            tasks = [];
                            String originalDate =
                                pendingProjects[index].endDate;
                            DateFormat inputFormat = DateFormat("MMM dd, yyyy");
                            DateFormat outputFormat = DateFormat("MMM dd");
                            DateTime parsedDate =
                                inputFormat.parse("$originalDate, 00:00:00");
                            String formattedDate =
                                outputFormat.format(parsedDate);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      projectId:
                                          pendingProjects[index].projectid,
                                    ),
                                  ),
                                );
                              },
                              child: OverviewCard(
                                projectName: pendingProjects[index].projectName,
                                index: index,
                                remainingTasks: count,
                                dueDate: formattedDate,
                              ),
                            );
                          });
                    }
                  },
                ),
                FutureBuilder(
                  future: projectServices.getCompletedProjects(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("An error occurred: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData|| snapshot.data.isEmpty) {
                      return const Center(
                        child: Text("No Completed Projects!"),
                      );
                    } else {
                      completedProjects = snapshot.data;
                      return ListView.builder(
                          itemCount: completedProjects.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      projectId:
                                          completedProjects[index].projectid,
                                    ),
                                  ),
                                );
                              },
                              child: OverviewCard(
                                projectName:
                                    completedProjects[index].projectName,
                                index: index,
                                remainingTasks: 0,
                                dueDate: "noDueDate",
                              ),
                            );
                          });
                    }
                  },
                ),
                FutureBuilder(
                  future: projectServices.fetchAllProducts(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("An error occurred: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData|| snapshot.data.isEmpty) {
                      return const Center(
                        child: Text("No Projects are added!"),
                      );
                    } else {
                      projectDataModel = snapshot.data;
                      return ListView.builder(
                          itemCount: projectDataModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            List<Task> tasks = projectDataModel[index].tasks;
                            int count = 0;
                            for (int i = 0; i < tasks.length; i++) {
                              if (tasks[i].status == false) {
                                count = count + 1;
                              }
                            }
                            tasks = [];
                            String originalDate =
                                projectDataModel[index].endDate;
                            DateFormat inputFormat = DateFormat("MMM dd, yyyy");
                            DateFormat outputFormat = DateFormat("MMM dd");
                            DateTime parsedDate =
                                inputFormat.parse("$originalDate, 00:00:00");
                            String formattedDate =
                                outputFormat.format(parsedDate);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      projectId:
                                          projectDataModel[index].projectid,
                                    ),
                                  ),
                                );
                              },
                              child: OverviewCard(
                                projectName:
                                    projectDataModel[index].projectName,
                                index: index,
                                remainingTasks: count,
                                dueDate: formattedDate,
                              ),
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTab extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return CirclePainter();
  }
}

class CirclePainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = Colors.black54;
    final Offset CirclePostion =
        Offset(configuration.size!.width - 3.0, configuration.size!.height / 2);
    canvas.drawCircle(offset + CirclePostion, 4, _paint);
  }
}
