import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../auth/services/auth_controller.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';

final projectRepositoryProvider = Provider((ref) => ProjectRepository());

class ProjectRepository {
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
    final userModel = ref.watch(userProvider);
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
          'x-auth-token': userModel!.token,
        },
        body: projectDataModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Project Successfully Added!');
          User user =
              userModel.copyWith(projects: jsonDecode(res.body)['projects']);
          ref.read(userProvider.notifier).update((state) => user);
          Navigator.pushReplacementNamed(context, BottomBar.routeName,
              arguments: 0);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<ProjectDataModel>> fetchAllProducts(
    ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    List<ProjectDataModel> projectList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-projects'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          projectList.add(
              ProjectDataModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }
    } catch (e) {
      throw e.toString();
    }
    return projectList;
  }
}
