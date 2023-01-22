import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';

import '../model/event_model.dart';

class TryScreen extends StatefulWidget {
  const TryScreen({Key? key}) : super(key: key);

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
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
    eventModel = eventServices.getDataList();
    print(eventModel.length);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30,),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Event Location'),
          ),
          RaisedButton(
            child: const Text('Add Event'),
            onPressed: () {
              for (int i = 0; i < eventModel.length; i++) {
                setState(() {
                  if (mySelectedEvents[eventModel[i].name] != null) {
                    mySelectedEvents[eventModel[i].name]
                        ?.add({
                      "eventTitle": eventModel[i].title,
                      "eventDesc": eventModel[i].title,
                    });
                  } else {
                    mySelectedEvents[eventModel[i].name] = [
                      {
                        "eventTitle": eventModel[i].title,
                        "eventDesc": eventModel[i].title,
                      }
                    ];
                  }
                });
                print(mySelectedEvents);
              }
            },
          ),
        ],
      ),
    );
  }

}
