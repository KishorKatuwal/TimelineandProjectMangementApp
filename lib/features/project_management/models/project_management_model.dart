import 'dart:convert';

class ProjectDataModel {
  final String projectid;
  final String projectName;
  final List<Task> tasks;

  ProjectDataModel({
    required this.projectid,
    required this.projectName,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'projectid': projectid});
    result.addAll({'projectName': projectName});
    result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      projectid: map['_id'] ?? '',
      projectName: map['projectName'] ?? '',
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataModel.fromJson(String source) =>
      ProjectDataModel.fromMap(json.decode(source));
}

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
      id: map['id'] ?? '',
      status: map['status'] ?? false,
      taskName: map['taskName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
