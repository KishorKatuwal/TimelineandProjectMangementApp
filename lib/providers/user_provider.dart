import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      group: '',
      faculty: '',
      year: '',
      type: '',
      token: '',
      password: '',
      events: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
