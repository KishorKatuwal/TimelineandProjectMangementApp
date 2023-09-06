import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_controller.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';

class ProjectServices {
  void addNewProject({
    required BuildContext context,
    required WidgetRef ref,
    required String projectName,
    required String projectDescription,
    required String startDate,
    required String endDate,
    required bool isCompleted,
    required List<Task> tasks,
  }) async {
    final user = ref.watch(userProvider);
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
          'x-auth-token': user!.token,
        },
        body: projectDataModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Project Successfully Added!');
          // User user = userProvider.user
          //     .copyWith(projects: jsonDecode(res.body)['projects']);
          // userProvider.setUserFromModel(user);
          // Navigator.pushNamed(context, BottomBar.routeName);
          Navigator.pushReplacementNamed(context, BottomBar.routeName,
              arguments: 0);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // method for fetching data
  Future<List<ProjectDataModel>> fetchAllProducts(
      {required BuildContext context, required WidgetRef ref}) async {
    final user = ref.watch(userProvider);
    List<ProjectDataModel> projectList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-projects'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user!.token,
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
    required WidgetRef ref,
    required bool status,
  }) async {
    final user = ref.watch(userProvider);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-tasks'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user!.token,
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
            // User user = userProvider.user
            //     .copyWith(projects: jsonDecode(res.body)['projects']);
            // userProvider.setUserFromModel(user);
            // Navigator.pop(context);
            // Navigator.pushReplacementNamed(context, BottomBar.routeName,
            //     arguments: 0);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => TaskDetailScreen(
            //       projectId: projectID,
            //     ),
            //   ),
            // );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  List<ProjectDataModel> completedProjects = [];
  List<ProjectDataModel> pendingProjects = [];
  List<ProjectDataModel> getProjects = [];

  //getting pending projects
  Future<List<ProjectDataModel>> getPendingProjects(
      {required BuildContext context, required WidgetRef ref}) async {
    getProjects = [];
    getProjects = await fetchAllProducts(context: context, ref: ref);
    for (int i = 0; i < getProjects.length; i++) {
      if (getProjects[i].isCompleted == false) {
        pendingProjects.add(getProjects[i]);
      }
    }
    pendingProjects.sort((a, b) => a.endDate.compareTo(b.endDate));
    return pendingProjects;
  }

  Future<List<ProjectDataModel>> getCompletedProjects(
      {required BuildContext context, required WidgetRef ref}) async {
    getProjects = [];
    getProjects = await fetchAllProducts(context: context, ref: ref);
    for (int i = 0; i < getProjects.length; i++) {
      if (getProjects[i].isCompleted == true) {
        completedProjects.add(getProjects[i]);
      }
    }
    return completedProjects;
  }

  void deleteProject({
    required BuildContext context,
    required String projectId,
    required WidgetRef ref,
  }) async {
    final user = ref.watch(userProvider);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-project'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user!.token,
        },
        body: jsonEncode({
          'projectId': projectId,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // User user = userProvider.user
            //     .copyWith(projects: jsonDecode(res.body)['projects']);
            // userProvider.setUserFromModel(user);
            // Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //update project status
  void updateProjectStatus(
      {required BuildContext context,
      required String projectID,
      required bool status,
      required WidgetRef ref}) async {
    final user = ref.watch(userProvider);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-project-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user!.token,
        },
        body: jsonEncode({
          'projectId': projectID,
          'projectStatus': status,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // User user = userProvider.user
            //     .copyWith(projects: jsonDecode(res.body)['projects']);
            // userProvider.setUserFromModel(user);
            // Navigator.pop(context);
            // Navigator.pushReplacementNamed(context, BottomBar.routeName,
            //     arguments: 0);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => TaskDetailScreen(
            //       projectId: projectID,
            //     ),
            //   ),
            // );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
