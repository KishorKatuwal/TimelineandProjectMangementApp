import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/add_event_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/view_addedEvent_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';

import '../model/event_data_model.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';

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

  List<EventDataModel> _eventsFromBackend = [];
  Map<String, List> _finalEvents = {};

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    getFinalData();
  }

  void getFinalData() async {
    mySelectedEvents = await getFinalDataList();
  }

  //fetching user events
  Future<Map<String, List>> getFinalDataList() async {
    _eventsFromBackend = await eventServices.fetchAllEvents(context);
    for (int i = 0; i < _eventsFromBackend.length; i++) {
      //checking key of date exists or not
      if (_finalEvents[_eventsFromBackend[i].EventDate] != null) {
        //there is already an entry for that date
        //add on existing entry
        _finalEvents[_eventsFromBackend[i].EventDate]?.add({
          "eventTitle": _eventsFromBackend[i].EventName,
          "eventType": _eventsFromBackend[i].EventType,
        });
      } else {
        //there is no existing entry for the date
        //creates new entry
        _finalEvents[_eventsFromBackend[i].EventDate] = [
          {
            "eventTitle": _eventsFromBackend[i].EventName,
            "eventType": _eventsFromBackend[i].EventType,
          }
        ];
      }
    }
    loading = true;
    setState(() {});
    print(_finalEvents);
    return _finalEvents;
  }

  //method for showing event details below calendar
  List _listofDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //removing icon from app bar
        automaticallyImplyLeading: false,
        title: const Text("Event Calendar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: loading
            ? Column(
                children: [
                  TableCalendar(
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        //colour of today's date when others selected
                          color: Color.fromRGBO(112, 141, 246, 1.0),
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                        //color of selected date
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      //color of weekend text
                      weekendTextStyle: TextStyle(color: Colors.red),
                      markerDecoration: BoxDecoration(
                          color: GlobalVariables.mainColor,
                          shape: BoxShape.circle),
                    ),
                    firstDay: DateTime(2023),
                    lastDay: DateTime(2024),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    weekendDays: const [6],
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      weekendStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
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
                  const Divider(
                    height: 3,
                    color: Colors.black26,
                    thickness: 2,
                  ),
                  //... is a spread operator used to iterate over all elements
                  ..._listofDayEvents(_selectedDate!).map(
                    (myEvents) => ListTile(
                      title: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(65, 105, 225, 0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Event Title: ${myEvents['eventTitle']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Event Type: ${myEvents['eventType']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //button for viewing events
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: CustomButton(
                        text: "View Your Events",
                        onTap: () {
                          Navigator.pushNamed(
                              context, ViewAddedEventScreen.routeName);
                        }),
                  ),
                  //button for adding new event
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: CustomButton(
                        text: "Add New Event",
                        onTap: () {
                          Navigator.pushNamed(
                              context, AddEventScreen.routeName);
                        }),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
