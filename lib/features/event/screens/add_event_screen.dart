import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelineandprojectmanagementapp/features/event/services/event_service.dart';
import 'package:timelineandprojectmanagementapp/notification/notification_service.dart';
import '../../../common/widgets/category_card.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfiels.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = '/add-event-screen';

  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _addEventFormKey = GlobalKey<FormState>();
  final NotificationService notificationService = NotificationService();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _repeatController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventTypeController = TextEditingController();
  final EventServices eventServices = EventServices();
  String eventRepeatValue = "Once";
  String category = "Event";
  late int hour;
  late int minute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.initialiseNotifications();
    _repeatController.text = eventRepeatValue;
    _eventTypeController.text = category;
  }

  _setCategory(String newCategory) {
    setState(() {
      category = newCategory;
      _eventTypeController.text = category;
    });
  }

  List<String> eventTypeCategories = [
    'Once',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventTypeController.dispose();
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventTimeController.dispose();
    _repeatController.dispose();
    _descriptionController.dispose();
  }

  void addNewEvent(int year, int month, int day, int weekDay) {
    eventServices.addNewEvent(
      context: context,
      EventName: _eventNameController.text,
      EventDate: _eventDateController.text,
      EventTime: _eventTimeController.text,
      Repeat: _repeatController.text,
      Description: _descriptionController.text,
      EventType: _eventTypeController.text,
      year: year,
      month: month,
      day: day,
      weekDay: weekDay,
      hour: hour,
      minute: minute,
    );
    print(year);
    print(month);
    print(day);
    print(hour);
    print(minute);
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
      setState(() {
        _eventTimeController.text = formattedTime;
        hour = pickedTime.hour;
        minute = pickedTime.minute;
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
                  Container(
                    margin: const EdgeInsets.only(right: 200),
                    child: const Text(
                      "Event Type",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _setCategory('Event');
                        },
                        child: CategoryCard(
                          categoryText: 'Event',
                          isActive: category == 'Event',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Holiday');
                        },
                        child: CategoryCard(
                          categoryText: 'Holiday',
                          isActive: category == 'Holiday',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Birthday');
                        },
                        child: CategoryCard(
                          categoryText: 'Birthday',
                          isActive: category == 'Birthday',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Exam');
                        },
                        child: CategoryCard(
                          categoryText: 'Exam',
                          isActive: category == 'Exam',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Assignment Due Date');
                        },
                        child: CategoryCard(
                          categoryText: 'Assignment Due Date',
                          isActive: category == 'Assignment Due Date',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Class');
                        },
                        child: CategoryCard(
                          categoryText: 'Class',
                          isActive: category == 'Class',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _setCategory('Others');
                        },
                        child: CategoryCard(
                          categoryText: 'Others',
                          isActive: category == 'Others',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 300),
                    child: const Text(
                      "Repeat",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Colors.black38,
                            width: 1,
                            style: BorderStyle.solid)),
                    child: DropdownButton(
                      alignment: Alignment.centerLeft,
                      isExpanded: true,
                      elevation: 0,
                      value: eventRepeatValue,
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: eventTypeCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          eventRepeatValue = newVal!;
                          _repeatController.text = eventRepeatValue;
                        });
                      },
                    ),
                  ),
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
                        DateTime date =
                            DateTime.parse(_eventDateController.text);
                        addNewEvent(
                            date.year, date.month, date.day, date.weekday);
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
