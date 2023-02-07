import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class AccountService {
  void updateUserDetails({
    required BuildContext context,
    required String name,
    required String group,
    required String faculty,
    required String year,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-user-details'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'name': name,
          'group': group,
          'faculty': faculty,
          'year': year,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              group: jsonDecode(res.body)['group'],
              name: jsonDecode(res.body)['name'],
              faculty: jsonDecode(res.body)['faculty'],
              year: jsonDecode(res.body)['year'],
            );
            userProvider.setUserFromModel(user);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
