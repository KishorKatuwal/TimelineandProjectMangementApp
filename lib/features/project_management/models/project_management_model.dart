import 'dart:convert';
import 'package:timelineandprojectmanagementapp/features/project_management/models/task_model.dart';

class ProjectDataModel {
  final String projectid;
  final String projectName;
  final String projectDescription;
  final String startDate;
  final String endDate;
  final bool isCompleted;
  final List<Task> tasks;

  ProjectDataModel({
    required this.projectid,
    required this.projectName,
    required this.projectDescription,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'projectid': projectid});
    result.addAll({'projectName': projectName});
    result.addAll({'projectDescription': projectDescription});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      projectid: map['_id'] ?? '',
      projectName: map['projectName'] ?? '',
      projectDescription: map['projectDescription'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataModel.fromJson(String source) =>
      ProjectDataModel.fromMap(json.decode(source));
}

