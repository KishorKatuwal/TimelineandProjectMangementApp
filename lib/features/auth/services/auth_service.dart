import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/login_screen.dart';
import 'package:timelineandprojectmanagementapp/model/user.dart';
import 'package:timelineandprojectmanagementapp/providers/user_provider.dart';

import '../../../admin/main_screen/admin_screen.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';

class AuthService {
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
      // Send a POST request to the signup API endpoint
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        //headers indicates that request body is in json format
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Handle the HTTP response and perform actions accordingly
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
          Navigator.pop(context);
        },
      );
    }
    // Handle any errors that occur during the process
    catch (e) {
      print("Program failed on catch on sign in USER");
      showSnackBar(context, e.toString());
    }
  }

  //method  for sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //saving data to the device
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          showSnackBar(
            context,
            'Successfully logged in!',
          );
          if (Provider.of<UserProvider>(context, listen: false).user.type ==
              'user') {
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, arguments: 0, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, AdminScreen.routeName, (route) => false);
          }
        },
      );
    } catch (e) {
      // print("Program failed on catch on signupUSER");
      print(e.toString());
      if (e.toString() == "Connection failed") {
        showSnackBar(context, "No internet connection!");
      } else if (e.toString() == "Connection timed out") {
        showSnackBar(context, "Server down!");
      } else {
        showSnackBar(context, e.toString());
      }
    }
  }

  // get user data
  void getUserData(BuildContext context) async {
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
        //getting the user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print("Program failed on get user data on catch");
      showSnackBar(context, e.toString());
    }
  }

  //method for logout user
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', "");
      await sharedPreferences.setBool('methodExecuted', false);
      //will not go back if back button pressed
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
