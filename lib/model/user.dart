// import 'dart:convert';
//
// class User {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String group;
//   final String faculty;
//   final String year;
//   final String type;
//   final String token;
//   final String password;
//   final String lastActiveTime;
//   final bool hideUser;
//   final List<dynamic> events;
//   final List<dynamic> projects;
//
//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.group,
//     required this.faculty,
//     required this.year,
//     required this.type,
//     required this.token,
//     required this.password,
//     required this.lastActiveTime,
//     required this.hideUser,
//     required this.events,
//     required this.projects,
//   });
//
//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
//     result.addAll({'id': id});
//     result.addAll({'firstName': firstName});
//     result.addAll({'lastName': lastName});
//     result.addAll({'email': email});
//     result.addAll({'group': group});
//     result.addAll({'faculty': faculty});
//     result.addAll({'year': year});
//     result.addAll({'type': type});
//     result.addAll({'token': token});
//     result.addAll({'password': password});
//     result.addAll({'lastActiveTime': lastActiveTime});
//     result.addAll({'hideUser': hideUser});
//     result.addAll({'events': events});
//     result.addAll({'projects': projects});
//
//     return result;
//   }
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['_id'] ?? '',
//       firstName: map['firstName'] ?? '',
//       lastName: map['lastName'] ?? '',
//       email: map['email'] ?? '',
//       group: map['group'] ?? '',
//       faculty: map['faculty'] ?? '',
//       year: map['year'] ?? '',
//       type: map['type'] ?? '',
//       token: map['token'] ?? '',
//       password: map['password'] ?? '',
//       lastActiveTime: map['lastActiveTime'] ?? '',
//       hideUser: map['hideUser'] ?? false,
//       events: List<Map<String, dynamic>>.from(
//         map['events']?.map(
//           (x) => Map<String, dynamic>.from(x),
//         ),
//       ),
//       projects: List<Map<String, dynamic>>.from(
//         map['projects']?.map(
//           (x) => Map<String, dynamic>.from(x),
//         ),
//       ),
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
//
//   User copyWith({
//     String? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? year,
//     String? group,
//     String? faculty,
//     String? type,
//     String? password,
//     String? lastActiveTime,
//     bool? hideUser,
//     String? token,
//     List<dynamic>? events,
//     List<dynamic>? projects,
//   }) {
//     return User(
//       id: id ?? this.id,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       group: group ?? this.group,
//       faculty: faculty ?? this.faculty,
//       year: year ?? this.year,
//       type: type ?? this.type,
//       token: token ?? this.token,
//       password: password ?? this.password,
//       lastActiveTime: lastActiveTime ?? this.lastActiveTime,
//       hideUser: hideUser ?? this.hideUser,
//       events: events ?? this.events,
//       projects: projects ?? this.projects,
//     );
//   }
// }

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String token;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String group;
  final String faculty;
  final String year;
  final String lastActiveTime;
  final String type;
  final bool hideUser;
  final List<dynamic> events;
  final List<dynamic> projects;

  User({
    required this.token,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.group,
    required this.faculty,
    required this.year,
    required this.lastActiveTime,
    required this.type,
    required this.hideUser,
    required this.events,
    required this.projects,
  });

  User copyWith({
    String? token,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? group,
    String? faculty,
    String? year,
    DateTime? lastActiveTime,
    String? type,
    bool? hideUser,
    List<dynamic>? events,
    List<dynamic>? projects,
  }) =>
      User(
        token: token ?? this.token,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        group: group ?? this.group,
        faculty: faculty ?? this.faculty,
        year: year ?? this.year,
        lastActiveTime: this.lastActiveTime,
        type: type ?? this.type,
        hideUser: hideUser ?? this.hideUser,
        events: events ?? this.events,
        projects: projects ?? this.projects,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        group: json["group"],
        faculty: json["faculty"],
        year: json["year"],
        lastActiveTime: json["lastActiveTime"],
        type: json["type"],
        hideUser: json["hideUser"],
        events: List<dynamic>.from(json["events"].map((x) => x)),
        projects: List<dynamic>.from(json["projects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "group": group,
        "faculty": faculty,
        "year": year,
        "lastActiveTime": lastActiveTime,
        "type": type,
        "hideUser": hideUser,
        "events": List<dynamic>.from(events.map((x) => x)),
        "projects": List<dynamic>.from(projects.map((x) => x)),
      };
}
