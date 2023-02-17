import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import 'package:http/http.dart' as http;
import '../../../providers/user_provider.dart';


class ViewUserService{
  //getting all the product from the database
  Future<List<User>> fetchAllUsers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/admin/get-users'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userList.add(User.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }


  //delete user
  void deleteUser(
      {required BuildContext context,
        required User userModel,
        required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': userModel.id,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      print("Failed on admin feedback service catch");
      showSnackBar(context, e.toString());
    }
  }


}