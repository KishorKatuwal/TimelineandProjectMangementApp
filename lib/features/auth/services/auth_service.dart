import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/home/screens/home_screen.dart';
import 'package:timelineandprojectmanagementapp/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/providers/user_provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../admin/screens/admin_screen.dart';

class AuthService {
  //function  for signup user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String group,
    required String faculty,
    required String year,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          group: group,
          faculty: faculty,
          year: year,
          type: '',
          token: '',
          password: password,
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
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      print("Program failed on catch on signupUSER");
      showSnackBar(context, e.toString());
    }
  }

  //funtion to signin user
  //function  for signup user
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
          Navigator.pushNamedAndRemoveUntil(
              context,
              Provider.of<UserProvider>(context, listen: false).user.type ==
                      'user'
                  ? BottomBar.routeName
                  : AdminScreen.routeName,
              (route) => false);

          showSnackBar(
            context,
            'Successfully logged in!',
          );
        },
      );
    } catch (e) {
      print("Program failed on catch on signupUSER");
      showSnackBar(context, e.toString());
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
        //get the user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print("Program failed on catch");
      showSnackBar(context, e.toString());
    }
  }
}
