import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/tasks_screen/task_detail.dart';

import '../../../providers/user_provider.dart';
import '../addNewProjectScreen/add_new_project.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';
import '../projects_screens/progress_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectModel = [];
  List<ProjectDataModel> projectData = [];
  DateTime _selectedDate = DateTime.now();

  void _onDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDate();
  }

  // void getDate() async {
  //   projectModel = await projectServices.fetchAllProducts(context);
  //   setState(() {});
  // }

  void deleteProject(String projectId) {
    setState(() {
      projectServices.deleteProject(context: context, projectId: projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final getLength = context.watch<UserProvider>().user.projects.length;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(242, 244, 255, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.assignment_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        const Text(
                          "User Projects ",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMM - d').format(_selectedDate),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddNewTask()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 123, 0, 245),
                              color: GlobalVariables.mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  "Add Project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: _selectedDate,
                      selectionColor: GlobalVariables.mainColor,
                      onDateChange: _onDateChange,
                    )
                  ],
                ),
              ),
              Container(
                // height: 200,
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Projects",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 395,
                        child: FutureBuilder(
                          future: projectServices.fetchAllProducts(context),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "An error occurred: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No Projects are added till now!"),
                              );
                            } else {
                              projectModel = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: projectModel.length,
                                  itemBuilder: (context, index) {
                                    //getting remaining days
                                    String date1 = projectModel[index].endDate;
                                    DateTime date2 = DateTime.now();
                                    DateFormat format =
                                        DateFormat("MMM dd, yy");
                                    DateTime d1 = format.parse(date1);
                                    Duration difference = d1.difference(date2);
                                    int days = difference.inDays;
                                    // print(projectModel[index].endDate);
                                    //getting completed percentage
                                    List<Task> tasks =
                                        projectModel[index].tasks;
                                    int count = 0;
                                    for (int i = 0; i < tasks.length; i++) {
                                      if (tasks[i].status == true) {
                                        count = count + 1;
                                      }
                                    }
                                    double completePercent =
                                        (count / tasks.length) * 100;
                                    tasks = [];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailScreen(
                                              projectId:
                                                  projectModel[index].projectid,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ProgressCard(
                                        ProjectName:
                                            projectModel[index].projectName,
                                        CompletedPercent:
                                            completePercent.toInt(),
                                        remainingDays: days,
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
                      ),
                    ],
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
