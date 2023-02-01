import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/Provider.dart';
import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';
import '../tasks_screen/task_detail.dart';

class ProjectServices {
  void addNewProject({
    required BuildContext context,
    required String projectName,
    required String projectDescription,
    required String startDate,
    required String endDate,
    required bool isCompleted,
    required List<Task> tasks,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      ProjectDataModel projectDataModel = ProjectDataModel(
          projectid: "",
          projectName: projectName,
          projectDescription: projectDescription,
          startDate: startDate,
          endDate: endDate,
          isCompleted: isCompleted,
          tasks: tasks);

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-project'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: projectDataModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Project Successfully Added!');
          User user = userProvider.user
              .copyWith(projects: jsonDecode(res.body)['projects']);
          userProvider.setUserFromModel(user);
          // Navigator.pushNamed(context, BottomBar.routeName);
          Navigator.pushReplacementNamed(context, BottomBar.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // method for fetching data
  Future<List<ProjectDataModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProjectDataModel> projectList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-projects'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // converting received json response into project data model
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              projectList.add(ProjectDataModel.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return projectList;
  }

//updating tasks
  void updateTask({
    required BuildContext context,
    required String projectID,
    required String taskID,
    required bool status,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-tasks'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'projectId': projectID,
          'taskId': taskID,
          'taskStatus': status,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(projects: jsonDecode(res.body)['projects']);
            userProvider.setUserFromModel(user);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, BottomBar.routeName);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailScreen(
                  projectId: projectID,
                ),
              ),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  //getting pending projects




//getting completed projects
List<ProjectDataModel> completedProjects = [];
List<ProjectDataModel> getProjects = [];

  Future<List<ProjectDataModel>> getCompletedProjects(BuildContext context)async{
    getProjects = await fetchAllProducts(context);
    for(int i=0; i<getProjects.length;i++){
      if(getProjects[i].isCompleted==true){
        completedProjects.add(getProjects[i]);
      }
      // print(completedProjects);
    }
    return completedProjects;
  }






}
