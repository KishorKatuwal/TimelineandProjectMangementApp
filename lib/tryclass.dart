// import 'package:flutter/material.dart';
// import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
// import 'package:timelineandprojectmanagementapp/constants/utils.dart';
// import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
// import 'features/project_management/models/project_management_model.dart';
// import 'features/project_management/models/task_model.dart';
//
// class TryScreen extends StatefulWidget {
//   static const String routeName = '/try-screen';
//   final String projectId;
//   final String projectName;
//   final String projectDescription;
//   final String startDate;
//   final String endDate;
//   final bool isCompleted;
//   final List<Task> tasks;
//
//   const TryScreen(
//       {Key? key,
//       required this.projectId,
//       required this.projectName,
//       required this.projectDescription,
//       required this.startDate,
//       required this.endDate,
//       required this.isCompleted,
//       required this.tasks})
//       : super(key: key);
//
//   @override
//   State<TryScreen> createState() => _TryScreenState();
// }
//
// class _TryScreenState extends State<TryScreen> {
//   final ProjectServices projectServices = ProjectServices();
//   List<ProjectDataModel> project = [];
//   late bool editedStatus;
//   List<Task> taskModel = [];
//
//   void updateTask(String projectID, String taskID) {
//     setState(() {
//       projectServices.updateTask(
//           context: context, projectID: projectID, taskID: taskID, status: true);
//     });
//     navigateToThisPageAgain();
//   }
//
//   void updateTaskToFalse(String projectID, String taskID) {
//     setState(() {
//       projectServices.updateTask(
//           context: context,
//           projectID: projectID,
//           taskID: taskID,
//           status: false);
//       navigateToThisPageAgain();
//     });
//   }
//
//   void navigateToThisPageAgain() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TryScreen(
//           projectId: widget.projectId,
//           projectName: widget.projectName,
//           projectDescription: widget.projectDescription,
//           startDate: widget.startDate,
//           endDate: widget.endDate,
//           isCompleted: widget.isCompleted,
//           tasks: widget.tasks,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.projectName),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text(
//               widget.projectDescription,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start date: ${widget.startDate}',
//               style: Theme.of(context).textTheme.subtitle2,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'End date: ${widget.endDate}',
//               style: Theme.of(context).textTheme.subtitle2,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Tasks:',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.tasks.length,
//                 itemBuilder: (context, index) {
//                   editedStatus = widget.tasks[index].status;
//                   return ListTile(
//                     title: Text(widget.tasks[index].taskName),
//                     leading: editedStatus
//                         ? const Icon(Icons.check_box)
//                         : const Icon(Icons.check_box_outline_blank),
//                     trailing: editedStatus
//                         ? ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 updateTaskToFalse(
//                                     widget.projectId, widget.tasks[index].id);
//                               });
//                             },
//                             child: const Text("Set as Incomplete"),
//                           )
//                         : ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 updateTask(
//                                     widget.projectId, widget.tasks[index].id);
//                               });
//                             },
//                             child: const Text("Set as Complete"),
//                           ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
