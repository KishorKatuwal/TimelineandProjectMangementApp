import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import '../addNewProjectScreen/add_new_project.dart';
import '../models/project_management_model.dart';
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
  DateTime _selectedDate = DateTime.now();

  void _onDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
      print(_selectedDate);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  void getDate() async {
    projectModel = await projectServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 30,
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMM, d').format(_selectedDate),
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
                                  "Add task",
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
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.vertical,
                      //   child: Column(children: [
                      //     ProgressCard(
                      //         ProjectName: "Project", CompletedPercent: 30),
                      //     ProgressCard(
                      //         ProjectName: "Project", CompletedPercent: 100),
                      //     ProgressCard(
                      //         ProjectName: "Project", CompletedPercent: 30),
                      //     ProgressCard(
                      //         ProjectName: "Project", CompletedPercent: 30),
                      //   ]),
                      // ),
                      SizedBox(
                        height: 395,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: projectModel.length,
                            itemBuilder: (context, index) {
                              String date1 = projectModel[index].endDate;
                              DateTime date2 = DateTime.now();
                              DateFormat format = DateFormat("MMM dd, yy");
                              DateTime d1 = format.parse(date1);
                              Duration difference = d1.difference(date2);
                              int days = difference.inDays;
                              print(projectModel[index].endDate);
                              return ProgressCard(
                                ProjectName: projectModel[index].projectName,
                                CompletedPercent: 30,
                                remainingDays: days,
                              );
                            }),
                      )
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
