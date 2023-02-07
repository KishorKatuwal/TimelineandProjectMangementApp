import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String group;
  final String faculty;
  final String year;
  final String type;
  final String token;
  final String password;
  final List<dynamic> events;
  final List<dynamic> projects;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.group,
    required this.faculty,
    required this.year,
    required this.type,
    required this.token,
    required this.password,
    required this.events,
    required this.projects,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'group': group});
    result.addAll({'faculty': faculty});
    result.addAll({'year': year});
    result.addAll({'type': type});
    result.addAll({'token': token});
    result.addAll({'password': password});
    result.addAll({'events': events});
    result.addAll({'projects': projects});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      group: map['group'] ?? '',
      faculty: map['faculty'] ?? '',
      year: map['year'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      events: List<Map<String, dynamic>>.from(
        map['events']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      projects: List<Map<String, dynamic>>.from(
        map['projects']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? year,
    String? group,
    String? faculty,
    String? type,
    String? password,
    String? token,
    List<dynamic>? events,
    List<dynamic>? projects,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      year: year ?? this.year,
      group: group ?? this.group,
      faculty: faculty ?? this.faculty,
      type: type ?? this.type,
      password: password ?? this.password,
      token: token ?? this.token,
      events: events ?? this.events,
      projects: events ?? this.projects,
    );
  }
}
