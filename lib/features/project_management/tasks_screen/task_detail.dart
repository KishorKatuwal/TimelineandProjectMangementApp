import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/project_controler.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';

import '../models/project_management_model.dart';

//details of every project
class TaskDetailScreen extends ConsumerStatefulWidget {
  final String projectId;

  const TaskDetailScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectDataModal = [];
  List<ProjectDataModel> projectData = [];
  late bool editedStatus;
  bool deleteLoader = false;
  bool completedLoader = false;
  bool statusLoader = false;

  void updateTask(String projectID, String taskID) {
    setState(() {
      projectServices.updateTask(
          ref: ref,
          context: context,
          projectID: projectID,
          taskID: taskID,
          status: true);
    });
  }

  void updateTaskToFalse(String projectID, String taskID) {
    setState(() {
      projectServices.updateTask(
          ref: ref,
          context: context,
          projectID: projectID,
          taskID: taskID,
          status: false);
    });
  }

  void deleteProject(String projectId) {
    projectServices.deleteProject(
        context: context, projectId: projectId, ref: ref);
  }

  void updateProjectStatus(String projectId, bool status) {
    projectServices.updateProjectStatus(
        ref: ref, context: context, projectID: projectId, status: status);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
     final data =  ref.read(projectDataProvider.future);
     projectDataModal = await data;
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return projectDataModal.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Project Detail"),
              centerTitle: true,
            ),
            body: Container(
              // color: GlobalVariables.backgroundColor,
              color: const Color.fromRGBO(242, 244, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Name:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      projectDataModal[0].projectName,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Project Description:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      projectDataModal[0].projectDescription,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Project Status:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    projectDataModal[0].isCompleted
                        ? Text(
                            "Completed",
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        : Text(
                            "Not Completed",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                    const SizedBox(height: 10),
                    Text(
                      'Dates:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Start date: ${projectDataModal[0].startDate}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'End date: ${projectDataModal[0].endDate}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Total Tasks: ${projectDataModal[0].tasks.length}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectDataModal[0].tasks.length,
                        itemBuilder: (context, index) {
                          editedStatus =
                              projectDataModal[0].tasks[index].status;
                          return Card(
                            child: ListTile(
                              title: Text(
                                  projectDataModal[0].tasks[index].taskName,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
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
                                          statusLoader = true;
                                        });
                                      },
                                      child: statusLoader
                                          ? const CircularProgressIndicator()
                                          : const Text("Set as Incomplete"),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          updateTask(
                                              projectDataModal[0].projectid,
                                              projectDataModal[0]
                                                  .tasks[index]
                                                  .id);
                                          statusLoader = true;
                                        });
                                      },
                                      child: statusLoader
                                          ? const CircularProgressIndicator()
                                          : const Text("Set as Complete "),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                        ),
                        onPressed: () {
                          deleteProject(projectDataModal[0].projectid);
                          setState(() {
                            deleteLoader = true;
                          });
                        },
                        child: deleteLoader
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(Icons.delete),
                                  Text(
                                    "Delete Project",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: ElevatedButton(
                        onPressed: () {
                          if (projectDataModal[0].isCompleted) {
                            updateProjectStatus(
                                projectDataModal[0].projectid, false);
                          } else {
                            updateProjectStatus(
                                projectDataModal[0].projectid, true);
                          }
                          setState(() {
                            completedLoader = true;
                          });
                        },
                        child: completedLoader
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: projectDataModal[0].isCompleted
                                    ? [
                                        const Icon(Icons.remove_done_outlined),
                                        const Text(
                                          "Set as Incomplete Project",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ]
                                    : [
                                        const Icon(Icons.check_circle_outline),
                                        const Text(
                                          "Set as Completed Project",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            color: const Color.fromRGBO(242, 244, 255, 1),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
