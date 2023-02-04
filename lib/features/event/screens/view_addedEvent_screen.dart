import 'package:flutter/material.dart';

import '../../../common/widgets/common_text.dart';
import '../model/event_data_model.dart';
import '../services/event_service.dart';

class ViewAddedEventScreen extends StatefulWidget {
  static const String routeName = '/view-added-event-screen';

  const ViewAddedEventScreen({Key? key}) : super(key: key);

  @override
  State<ViewAddedEventScreen> createState() => _ViewAddedEventScreenState();
}

class _ViewAddedEventScreenState extends State<ViewAddedEventScreen> {
  final EventServices eventServices = EventServices();
  List<EventDataModel> eventModel = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getDate();
  // }

  void getDate() async {
    eventModel = await eventServices.fetchAllProducts(context);
    print(eventModel.length);
    setState(() {});
  }

  void deleteProduct(String eventId) {
    eventServices.deleteEvent(context: context, eventID: eventId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Events"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: eventServices.fetchAllProducts(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData|| snapshot.data.isEmpty) {
            return const Center(
              child: Text("No Events are added"),
            );
          } else {
            eventModel = snapshot.data;
            return ListView.builder(
              itemCount: eventModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    right: 8,
                    left: 8,
                    bottom: 4
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      // bottom: 10
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text(eventModel[index].EventName,
                          style: const TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      children: [
                        const Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CommonText(
                                  text: eventModel[index].EventDate,
                                  headText: "Event Date: "),
                              CommonText(
                                  text: eventModel[index].EventTime,
                                  headText: "Event Time: "),
                              CommonText(
                                  text: eventModel[index].Subject,
                                  headText: "Event Subject: "),
                              CommonText(
                                  text: eventModel[index].EventType,
                                  headText: "Event Type: "),
                              CommonText(
                                  text: eventModel[index].Description,
                                  headText: "Event Description: \n"),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.edit_calendar,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Edit Event"),
                                ],
                              ),
                              onPressed: () {
                                print("Edit Button Pressed");
                              },
                            ),
                            ElevatedButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Delete Event",
                                  ),
                                ],
                              ),
                              onPressed: () {
                                deleteProduct(eventModel[index].EventID);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
