import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';

import '../model/ecent_try_model.dart';

class TryScreen extends StatefulWidget {
  const TryScreen({Key? key}) : super(key: key);

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final subjectController = TextEditingController();
  final eventTimeController = TextEditingController();
  final eventTypeController = TextEditingController();

  final EventServices eventServices = EventServices();

  Map<String, List> mySelectedEvents = {};
  List<EventModel> eventModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  void getDate() {
    print(eventModel.length);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: eventNameController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          TextField(
            controller: eventDateController,
            decoration: const InputDecoration(labelText: 'Event Date'),
          ),
          TextField(
            controller: eventTimeController,
            decoration: const InputDecoration(labelText: 'Event Time'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Event Description'),
          ),
          TextField(
            controller: subjectController,
            decoration: const InputDecoration(labelText: 'Event Subject'),
          ),
          TextField(
            controller: eventTypeController,
            decoration: const InputDecoration(labelText: 'Event Type'),
          ),
          ElevatedButton(
            child: const Text('Add Event'),
            onPressed: () {
              eventServices.addNewEvent(context: context,
                  EventName: eventNameController.text,
                  EventDate: eventDateController.text,
                  EventTime: eventTimeController.text,
                  Subject: subjectController.text,
                  Description: descriptionController.text,
                  EventType: eventTypeController.text);
            },
          ),
        ],
      ),
    );
  }
}
