import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import '../models/project_management_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final String projectId;

  const TaskDetailScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectDataModal = [];
  List<ProjectDataModel> projectData = [];
  late bool editedStatus;

  void updateTask(String projectID, String taskID) {
    setState(() {
      projectServices.updateTask(
          context: context, projectID: projectID, taskID: taskID, status: true);
    });
  }

  void updateTaskToFalse(String projectID, String taskID) {
    setState(() {
      projectServices.updateTask(
          context: context,
          projectID: projectID,
          taskID: taskID,
          status: false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final projectData = await projectServices.fetchAllProducts(context);
    for (int i = 0; i < projectData.length; i++) {
      if (projectData[i].projectid == widget.projectId) {
        setState(() {
          projectDataModal.add(projectData[i]);
        });
        print(projectDataModal[0].projectName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return projectDataModal.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text(projectDataModal[0].projectName),
            ),
            body: Container(
              // color: GlobalVariables.backgroundColor,
              color: const Color.fromRGBO(242, 244, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      projectDataModal[0].projectDescription,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start date: ${projectDataModal[0].startDate}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'End date: ${projectDataModal[0].endDate}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Tasks:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectDataModal[0].tasks.length,
                        itemBuilder: (context, index) {
                          editedStatus =
                              projectDataModal[0].tasks[index].status;
                          return ListTile(
                            title:
                                Text(projectDataModal[0].tasks[index].taskName),
                            leading: editedStatus
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.black,
                                  ),
                            trailing: editedStatus
                                ? ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        updateTaskToFalse(
                                            projectDataModal[0].projectid,
                                            projectDataModal[0]
                                                .tasks[index]
                                                .id);
                                      });
                                    },
                                    child: const Text("Set as Incomplete"),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        updateTask(
                                            projectDataModal[0].projectid,
                                            projectDataModal[0]
                                                .tasks[index]
                                                .id);
                                      });
                                    },
                                    child: const Text("Set as Complete"),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
