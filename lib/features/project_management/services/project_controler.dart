import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/project_repository.dart';

import '../models/project_management_model.dart';
import '../models/task_model.dart';

final projectControllerProvider = Provider((ref) {
  final projectRepository = ref.watch(projectRepositoryProvider);
  return ProjectController(projectRepository: projectRepository, ref: ref);
});


final projectDataProvider = FutureProvider<List<ProjectDataModel>>((ref) async{
  final projectRepository = ref.watch(projectRepositoryProvider);
  return  projectRepository.fetchAllProducts();
});

class ProjectController {
  final ProjectRepository projectRepository;
  final ProviderRef ref;

  ProjectController({required this.projectRepository, required this.ref});

  void addNewProject({
    required BuildContext context,
    required WidgetRef ref,
    required String projectName,
    required String projectDescription,
    required String startDate,
    required String endDate,
    required bool isCompleted,
    required List<Task> tasks,
  }) {
    projectRepository.addNewProject(
        context: context,
        ref: ref,
        projectName: projectName,
        projectDescription: projectDescription,
        startDate: startDate,
        endDate: endDate,
        isCompleted: isCompleted,
        tasks: tasks);
  }

  Future<List<ProjectDataModel>> fetchAllProjects() {
    return projectRepository.fetchAllProducts();
  }


}
