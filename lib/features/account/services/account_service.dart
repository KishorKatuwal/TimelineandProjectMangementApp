import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class AccountService {

  void updateUserDetails({
    required BuildContext context,
    required String firstName,
    required String lastName,
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
          'firstName': firstName,
          'lastName': lastName,
          'group': group,
          'faculty': faculty,
          'year': year,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully edited!!");
            User user = userProvider.user.copyWith(
              group: jsonDecode(res.body)['group'],
              firstName: jsonDecode(res.body)['firstName'],
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





  void updateLastActiveDate({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      DateTime now = DateTime.now();
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-last-active'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'lastActiveTime': now.toString(),
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async{
            User user = userProvider.user.copyWith(
              lastActiveTime: jsonDecode(res.body)['lastActiveTime'],
            );
            userProvider.setUserFromModel(user);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('methodExecuted', true);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }





}
