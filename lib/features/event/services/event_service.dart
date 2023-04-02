import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/ecent_try_model.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/event/model/event_data_model.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/event_screen.dart';
import 'package:timelineandprojectmanagementapp/notification/notification_service.dart';
import 'package:timelineandprojectmanagementapp/tryclass.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/view_addedEvent_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/view_event_screen.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class EventServices {
  NotificationService notificationService = NotificationService();
  final Random random = Random.secure();

  void addNewEvent({
    required BuildContext context,
    required String EventName,
    required String EventDate,
    required String EventTime,
    required String Repeat,
    required String Description,
    required String EventType,
    required int year,
    required int month,
    required int day,
    required int weekDay,
    required int hour,
    required int minute,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    notificationService.initialiseNotifications();
    try {
      EventDataModel eventDataModel = EventDataModel(
          EventID: '',
          EventName: EventName,
          EventDate: EventDate,
          EventTime: EventTime,
          Repeat: Repeat,
          Description: Description,
          EventType: EventType);

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-event'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: eventDataModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Event Successfully Added!');
          User user = userProvider.user
              .copyWith(events: jsonDecode(res.body)['events']);
          userProvider.setUserFromModel(user);
          Navigator.pushReplacementNamed(context, BottomBar.routeName,
              arguments: 2);
          if (Repeat == "Once") {
            int id= random.nextInt(50) + 50;
            notificationService.scheduleNotificationOnce(
                id, year, month, day, hour, minute, EventName, EventType);
            print("Notification added Once");
          } else if (Repeat == "Daily") {
            int id= random.nextInt(101) + 50;
            notificationService.scheduleDailyEventNotification(
                id, hour, minute, EventName, EventType);
            print("Notification added Daily");
          } else if (Repeat == "Weekly") {
            int id= random.nextInt(200) + 50;
            notificationService.scheduleWeeklyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Weekly");
          } else if (Repeat == "Monthly") {
            int id= random.nextInt(300) + 50;
            notificationService.scheduleMonthlyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Monthly");
          } else {
            int id= random.nextInt(400) + 50;
            notificationService.scheduleYearlyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Yearly");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void editEvent({
    required BuildContext context,
    required String EventName,
    required String EventDate,
    required String EventTime,
    required String Repeat,
    required String Description,
    required String EventType,
    required String EventID,
    required int year,
    required int month,
    required int day,
    required int weekDay,
    required int hour,
    required int minute,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    notificationService.initialiseNotifications();
    try {
      EventDataModel eventDataModel = EventDataModel(
          EventID: EventID,
          EventName: EventName,
          EventDate: EventDate,
          EventTime: EventTime,
          Repeat: Repeat,
          Description: Description,
          EventType: EventType);

      http.Response res = await http.put(
        Uri.parse('$uri/api/edit-event'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: eventDataModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Event Successfully Added!');
          User user = userProvider.user
              .copyWith(events: jsonDecode(res.body)['events']);
          userProvider.setUserFromModel(user);
          Navigator.pushReplacementNamed(context, BottomBar.routeName,
               arguments: 2);
          if (Repeat == "Once") {
            int id= random.nextInt(50) + 50;
            notificationService.scheduleNotificationOnce(
                id, year, month, day, hour, minute, EventName, EventType);
            print("Notification added Once");
          } else if (Repeat == "Daily") {
            int id= random.nextInt(101) + 50;
            notificationService.scheduleDailyEventNotification(
                id, hour, minute, EventName, EventType);
            print("Notification added Daily");
          } else if (Repeat == "Weekly") {
            int id= random.nextInt(200) + 50;
            notificationService.scheduleWeeklyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Weekly");
          } else if (Repeat == "Monthly") {
            int id= random.nextInt(300) + 50;
            notificationService.scheduleMonthlyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Monthly");
          } else {
            int id= random.nextInt(400) + 50;
            notificationService.scheduleYearlyNotification(id, year, month,
                day, weekDay, hour, minute, EventName, EventType);
            print("Notification added Yearly");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // method for fetching data
  Future<List<EventDataModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<EventDataModel> eventList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-events'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // convert received json response into product model
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              eventList.add(
                  EventDataModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return eventList;
  }

  void deleteEvent({
    required BuildContext context,
    required String eventID,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-events'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'EventID': eventID,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(events: jsonDecode(res.body)['events']);
            userProvider.setUserFromModel(user);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, BottomBar.routeName,
                arguments: 2);
            Navigator.pushNamed(context, ViewAddedEventScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //getting upcoming events
  List<EventDataModel> upcomingEvents = [];
  List<EventDataModel> getEvents = [];
  Future<List<EventDataModel>> getUpcomingEvents(BuildContext context) async {
    getEvents = await fetchAllProducts(context);
    for (int i = 0; i < getEvents.length; i++) {
      String date1 = getEvents[i].EventDate;
      DateTime date2 = DateTime.now();
      Duration difference = DateTime.parse(date1).difference(date2);
      int differenceInDays = difference.inDays;
      if (differenceInDays >= 0) {
        upcomingEvents.add(getEvents[i]);
      }
    }
    upcomingEvents.sort((a, b) => a.EventDate.compareTo(b.EventDate));
    return upcomingEvents;
  }
}
