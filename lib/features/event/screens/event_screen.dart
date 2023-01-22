import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/event_model.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  final EventServices eventServices = EventServices();
  Map<String, List> mySelectedEvents = {};
  final titleController = TextEditingController();
  final descController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    // getFinalData();
    loadPreviousEvent();
  }

  void loadPreviousEvent() {
    mySelectedEvents = {
      "2023-1-22": [
        {"eventTitle": "Title 1", "eventDesc": "Title 1"},
        {"eventTitle": "Title 3", "eventDesc": "Title 3"}
      ],
      "2023-1-12": [{"eventTitle": "Title 2", "eventDesc": "Title 2"}],
      "2023-1-20": [{"eventTitle": "Title 4", "eventDesc": "Title 4"}]
    };
    loading=true;
  }

  void getFinalData() {
    mySelectedEvents = eventServices.getFinalDataList();
    loading = true;
    setState(() {});
    print("New event for backed Developer ${json.encode(mySelectedEvents)}");
  }


  List _listofDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }


  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text(
              "Add new Event",
              textAlign: TextAlign.center,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: descController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (titleController.text.isEmpty &&
                      descController.text.isEmpty) {
                    showSnackBar(context, "Required title and description");
                  } else {
                    setState(() {
                      if (mySelectedEvents[
                      DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                          null) {
                        mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                            ?.add({
                          "eventTitle": titleController.text,
                          "eventDesc": descController.text,
                        });
                      } else {
                        mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                          {
                            "eventTitle": titleController.text,
                            "eventDesc": descController.text,
                          }
                        ];
                      }
                    });
                    Navigator.pop(context);
                    return;
                  }
                },
                child: const Text('Add Event'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Calendar"),
        centerTitle: true,
      ),
      body: loading ? Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDate, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDate)) {
                setState(() {
                  _selectedDate = selectedDate;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _listofDayEvents,
          ),

          ..._listofDayEvents(_selectedDate!).map((myEvents) =>
              ListTile(
                leading: const Icon(Icons.done, color: Colors.teal,),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text("Event Title: ${myEvents['eventTitle']}"),
                ),
                subtitle: Text("Decoration: ${myEvents['eventDesc']}"),
              ),),


        ],
      ) : Center(child: CircularProgressIndicator(),),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showAddEventDialog();
          },
          label: Text("Add Event")),
    );
  }
}
