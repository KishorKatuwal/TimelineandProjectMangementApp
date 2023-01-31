import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import 'features/project_management/models/project_management_model.dart';
import 'features/project_management/models/task_model.dart';

class TryScreen extends StatefulWidget {
  static const String routeName = '/try-screen';

  const TryScreen({Key? key}) : super(key: key);

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectModel = [];
  List<Task> taskModel = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  void getDate() async{
    projectModel = await projectServices.fetchAllProducts(context);
  }

  void printProject() async {
   for(int i =0; i<projectModel.length; i++){
     print(projectModel[i].projectName);
     print(projectModel[i].startDate);
     print(projectModel[i].endDate);
     print(projectModel[i].projectDescription);
     print(projectModel[i].isCompleted);
     print(projectModel[i].projectid);
   }
  }

  void printTask() async{
    for(int i =0; i<projectModel.length; i++){
      taskModel = projectModel[i].tasks;
      for(int j=0; j<taskModel.length;j++){
        print(taskModel[i].taskName);
        print(taskModel[i].id);
        print(taskModel[i].status);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
      ),
      body: SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                printProject();
              }, child: const Text("Print Project")),
              ElevatedButton(onPressed: () {
                printTask();
              }, child: const Text("Print Task")),
            ],
          ),
        ),
      ),
    );
  }
}
