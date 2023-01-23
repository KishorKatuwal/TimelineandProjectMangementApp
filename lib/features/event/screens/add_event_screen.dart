import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfiels.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _addEventFormKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventTypeController = TextEditingController();

  final EventServices eventServices=EventServices();

  void addNewEvent(){
    eventServices.addNewEvent(context: context,
        EventName: _eventNameController.text,
        EventDate: _eventDateController.text,
        EventTime: _eventTimeController.text,
        Subject: _subjectController.text,
        Description: _descriptionController.text,
        EventType: _eventTypeController.text);
  }

  void openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        _eventDateController.text = formattedDate;
      });
    }
  }

  void openTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      print(formattedTime);
      setState(() {
        _eventTimeController.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Event"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _addEventFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextField(
                      controller: _eventNameController, hintText: "Event Name"),
                  TextFormField(
                    controller: _eventDateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Event Date"),
                    readOnly: true,
                    onTap: () {
                      openDatePicker();
                    },
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Event date is required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _eventTimeController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.access_time), labelText: "Event Time"),
                    readOnly: true,
                    onTap: () {
                      openTimePicker();
                    },
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Event time is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: _eventTypeController, hintText: "Event Type"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: _subjectController, hintText: "Subject"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: "Event Description",
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  CustomButton(
                    text: "Add Event",
                    onTap: () {
                      if (_addEventFormKey.currentState!.validate()) {
                        print("Button Pressed");
                        addNewEvent();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
