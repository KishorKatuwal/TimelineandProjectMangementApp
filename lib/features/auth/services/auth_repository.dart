import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelineandprojectmanagementapp/model/error_model.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  AuthRepository();

  //method for signup user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String group,
    required String faculty,
    required String year,
  }) async {
    try {
      DateTime now = DateTime.now();
      User user = User(
        id: '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        group: group,
        faculty: faculty,
        year: year,
        type: '',
        token: '',
        password: password,
        lastActiveTime: now.toString(),
        hideUser: false,
        events: [],
        projects: [],
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    }
    // Handle any errors that occur during the process
    catch (e) {
      print("Program failed on catch on sign in USER");
      showSnackBar(context, e.toString());
    }
  }

  Future<User> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    late User user;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.statusCode);
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     // SharedPreferences prefs = await SharedPreferences.getInstance();
      //     // await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
      //     user = userFromJson(res.body);
      //   },
      // );
      if(res.statusCode==200){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            user = userFromJson(res.body);
      }
    } catch (e) {
      throw e.toString();
    }
    return user;
  }

  Future<ErrorModel> getUserData(BuildContext context) async {
    ErrorModel errorModel = ErrorModel(error: "error", data: null);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        errorModel = ErrorModel(error: null, data: userFromJson(userRes.body));
      }
    } catch (e) {
      print("Program failed on get user data on catch");
      errorModel = ErrorModel(error: "error", data: null);
    }
    return errorModel;
  }
}
