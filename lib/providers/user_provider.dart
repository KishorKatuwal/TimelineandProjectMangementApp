import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    group: '',
    faculty: '',
    year: '',
    type: '',
    token: '',
    password: '',
    lastActiveTime: '',
    hideUser: false,
    events: [],
    projects: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(jsonDecode(user));
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
