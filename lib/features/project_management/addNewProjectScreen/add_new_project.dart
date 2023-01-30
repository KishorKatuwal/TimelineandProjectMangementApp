import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import '../../../constants/global_variables.dart';
import '../models/project_management_model.dart';
import '../models/task_model.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _Titlecontroller = TextEditingController();
  late TextEditingController _startDatecontroller;
  late TextEditingController _endDatecontroller;
  final TextEditingController _descriptionController = TextEditingController();
  final bool isCompleted = false;
  final _formKey = GlobalKey<FormState>();
  final _allformKey = GlobalKey<FormState>();
  final List<Task> _tasks = [];
  String _newTaskName = "";
  bool _newTaskStatus = false;
  final TextEditingController _taskNameController = TextEditingController();
  DateTime SelectedDate = DateTime.now();
  final ProjectServices projectServices = ProjectServices();

  void addNewProject() {
    projectServices.addNewProject(
        context: context,
        projectName: _Titlecontroller.text,
        projectDescription: _descriptionController.text,
        startDate: _startDatecontroller.text,
        endDate: _endDatecontroller.text,
        isCompleted: isCompleted,
        tasks: _tasks);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDatecontroller = TextEditingController(
        text: DateFormat('MMM d, ' 'yy').format(SelectedDate));
    _endDatecontroller = TextEditingController(
        text: DateFormat('MMM d, ' 'yy').format(SelectedDate));
  }

  _selectDate(BuildContext context, String DateType) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        if (DateType == "StartDate") {
          _startDatecontroller.text =
              DateFormat('MMM d, ' 'yy').format(selected);
        } else {
          _endDatecontroller.text = DateFormat('MMM d, ' 'yy').format(selected);
        }
      });
    }
  }

  void _addTask() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Task Name'),
                    onChanged: (value) {
                      _newTaskName = value;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter all empty fields!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _tasks.add(Task(
                        id: "",
                        taskName: _newTaskName,
                        status: _newTaskStatus));
                    _newTaskName = "";
                    _newTaskStatus = false;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            // color: Color.fromRGBO(130, 0, 255, 1),
            color: GlobalVariables.mainColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _allformKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                size: 30, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          const Text(
                            "Create New Project",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: _Titlecontroller,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: "Title",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter all empty fields!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 8,
                        cursorColor: Colors.black26,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          labelText: "Description",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter all empty fields!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _startDatecontroller,
                                    decoration: InputDecoration(
                                      labelText: "Start Date",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _selectDate(context, "StartDate");
                                        },
                                        child: const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.black26,
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                      fillColor: Colors.black26,
                                      labelStyle: const TextStyle(
                                        color: Colors.black26,
                                        fontSize: 15,
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Enter all empty fields!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _endDatecontroller,
                                    decoration: InputDecoration(
                                      labelText: "End Date",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _selectDate(context, "EndDate");
                                        },
                                        child: const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.black26,
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                      fillColor: Colors.black26,
                                      labelStyle: const TextStyle(
                                        color: Colors.black26,
                                        fontSize: 15,
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Enter all empty fields!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text("Tasks",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: _tasks.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No tasks are added",
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _tasks.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Task ${index + 1}: ",
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            Expanded(
                                              child: Text(
                                                  _tasks[index].taskName,
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                int taskIndex = index;
                                                Task taskToEdit =
                                                    _tasks[taskIndex];
                                                _taskNameController.text =
                                                    _tasks[taskIndex].taskName;

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Edit Task"),
                                                      content: Form(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            TextFormField(
                                                              controller:
                                                                  _taskNameController,
                                                              // initialValue: taskToEdit.taskName,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      labelText:
                                                                          "Task Name"),
                                                              validator: (val) {
                                                                if (val ==
                                                                        null ||
                                                                    val.isEmpty) {
                                                                  return "Enter all empty fields!";
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "Cancel"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "Save"),
                                                          onPressed: () {
                                                            setState(() {
                                                              Task updatedTask =
                                                                  Task(
                                                                id: taskToEdit
                                                                    .id,
                                                                status:
                                                                    taskToEdit
                                                                        .status,
                                                                taskName:
                                                                    _taskNameController
                                                                        .text,
                                                              );
                                                              _tasks[taskIndex] =
                                                                  updatedTask;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _tasks.removeAt(index);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.black12,
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GlobalVariables.mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // color: GlobalVariables.mainColor,
                                child: TextButton(
                                  child: const Text(
                                    "+ Add a new Task",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _addTask();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Button Presses");
                              if (_allformKey.currentState!.validate()) {
                                if (_tasks.isEmpty) {
                                  showSnackBar(context,
                                      "Please add a Task before creating project");
                                }else{
                                  addNewProject();
                                }
                                // Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // color: Color.fromRGBO(130, 0, 255, 1),
                                color: GlobalVariables.mainColor,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Create Project",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      // height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: GlobalVariables.mainColor,
                        height: 50,
                        width: double.infinity,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
