import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/event_data_model.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import '../../../providers/user_provider.dart';

class ListEventScreen extends StatefulWidget {
  final int index;

  const ListEventScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {
  EventServices eventServices = EventServices();

  void deleteProduct(String eventId) {
    eventServices.deleteEvent(context: context, eventID: eventId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final eventList = context.watch<UserProvider>().user.events[widget.index];
    final events = EventDataModel.fromMap(eventList);
    return eventList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Card(
              child: Row(
                children: [
                  Expanded(
                    child: Text(events.EventID),
                  ),
                  IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        deleteProduct(events.EventID);
                      })
                ],
              ),
            ),
          );
  }
}
