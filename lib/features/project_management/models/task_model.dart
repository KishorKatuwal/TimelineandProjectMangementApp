import 'dart:convert';

class Task {
  final String id;
  final bool status;
  final String taskName;

  Task({required this.id, required this.status, required this.taskName});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'status': status});
    result.addAll({'taskName': taskName});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['_id'] ?? '',
      status: map['status'] ?? false,
      taskName: map['taskName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
