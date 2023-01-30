import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import 'features/project_management/models/project_management_model.dart';

class TryScreen extends StatefulWidget {
  static const String routeName = '/try-screen';

  const TryScreen({Key? key}) : super(key: key);

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  final ProjectServices projectServices = ProjectServices();
  final _formKey = GlobalKey<FormState>();
  final List<Task> _tasks = [];
  String _newTaskId = "12";
  String _newTaskName = "Project";
  bool _newTaskStatus = false;

  void addProject() {
    projectServices.addNewProject(context: context, projectName: "New Project",tasks: _tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Project'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Project Name'),
              validator: (value) {
                if (value == "" || value == null) {
                  return 'Please enter a project name';
                }
                return null;
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Text(_tasks[0].taskName);
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                _addNewTask();
              },
              child: Text('Add Task'),
            ),
            RaisedButton(
              onPressed: () {
                addProject();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewTask() {
    if (_newTaskName.isEmpty || _newTaskId.isEmpty) {
// Show an alert dialog here
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please enter a task name and task id'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else {
      setState(() {
        _tasks.add(Task(id: "12", status: false, taskName: "new Task"));
        print(_tasks);

        // _newTaskName = "";
        // _newTaskId = "";
        // _newTaskStatus = false;
      });
    }
  }
}
