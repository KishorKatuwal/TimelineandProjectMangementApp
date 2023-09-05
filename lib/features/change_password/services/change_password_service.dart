import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class ChangePasswordService{
  //change password
  void changePassword({
    required BuildContext context,
    required String previousPassword,
    required String newPassword,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/change-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'previousPassword': previousPassword,
          'newPassword': newPassword,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully changed password!!");
            User user = userProvider.user.copyWith(
              password: jsonDecode(res.body)['password'],
            );
            userProvider.setUserFromModel(user);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}