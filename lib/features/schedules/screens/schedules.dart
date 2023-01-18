import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/services/schedules_service.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({Key? key}) : super(key: key);

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  final SchedulesService schedulesService = SchedulesService();
  String formattedDate = DateFormat('E').format(DateTime.now()).toUpperCase();

  List<List<dynamic>> _data = [];

  void gettingData() async {
    _data = await schedulesService.loadListFromCSV(formattedDate);
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
      appBar: AppBar(
        title: const Text("Today Classes"),
        centerTitle: true,
      ),
      // Display the contents from the CSV file
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (_, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _data[index][4],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Module Code: ${_data[index][3]}"),
                        Text("Class Type: ${_data[index][2]}"),
                        Text("Day: ${_data[index][0]}"),
                        Text("Time: ${_data[index][1]}"),
                        Text("Lecture: ${_data[index][5]}"),
                        Text("Group: ${_data[index][6]}"),
                        Text("Block: ${_data[index][7]}"),
                        Text("Room: ${_data[index][8]}"),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
