import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/services/schedules_service.dart';

import '../../../providers/user_provider.dart';

class SchedulesPage extends StatefulWidget {
  final String Weekday;
  final String Group;
  const SchedulesPage({Key? key, required this.Weekday, required this.Group}) : super(key: key);

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  final SchedulesService schedulesService = SchedulesService();
  final AuthService authService= AuthService();
  String formattedDate = DateFormat('E').format(DateTime.now()).toUpperCase();

  List<List<dynamic>> _data = [];

  void gettingData() async {
    _data = await schedulesService.loadListFromCSV(widget.Weekday, widget.Group);
    print(_data);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _data.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data.length,
                      itemBuilder: (_, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 4,
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: GlobalVariables.mainColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _data[index][4],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text("Module Code: ${_data[index][3]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Class Type: ${_data[index][2]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Day: ${_data[index][0]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Time: ${_data[index][1]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Lecture: ${_data[index][5]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Group: ${_data[index][6]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Block: ${_data[index][7]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Room: ${_data[index][8]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
          : const Center(
              child: Text(
                "No Classes Today",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
