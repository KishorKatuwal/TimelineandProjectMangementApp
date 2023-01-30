import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/Provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';
import '../models/project_management_model.dart';

class ProjectServices {
  void addNewProject({
    required BuildContext context,
    required String projectName,
    required List<Task> tasks,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      ProjectDataModel projectDataModel = ProjectDataModel(
          projectid: "", projectName: projectName,tasks: tasks);

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
          // Navigator.pushReplacementNamed(context, BottomBar.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
