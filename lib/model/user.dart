import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String group;
  final String faculty;
  final String year;
  final String type;
  final String token;
  final String password;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.group,
    required this.faculty,
    required this.year,
    required this.type,
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'group': group});
    result.addAll({'faculty': faculty});
    result.addAll({'year': year});
    result.addAll({'type': type});
    result.addAll({'token': token});
    result.addAll({'password': password});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      group: map['group'] ?? '',
      faculty: map['faculty'] ?? '',
      year: map['year'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
