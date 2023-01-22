import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/ecent_try_model.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/event/model/event_data_model.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class EventServices {
  List<EventModel> _events = [];
  Map<String, List> _finalEvents = {};

  List<EventModel> getDataList() {
    return [
      EventModel(
          name: '2023-01-22', description: 'Description 1', title: 'Title 1'),
      EventModel(
          name: '2023-01-12', description: 'Description 2', title: 'Title 2'),
      EventModel(
          name: '2023-01-22', description: 'Description 3', title: 'Title 3'),
      EventModel(
          name: '2023-01-20', description: 'Description 4', title: 'Title 4'),
    ];
  }

  Map<String, List> getFinalDataList() {
    _events = getDataList();
    for (int i = 0; i < _events.length; i++) {
      if (_finalEvents[_events[i].name] != null) {
        _finalEvents[_events[i].name]?.add({
          "eventTitle": _events[i].title,
          "eventDesc": _events[i].title,
        });
      } else {
        _finalEvents[_events[i].name] = [
          {
            "eventTitle": _events[i].title,
            "eventDesc": _events[i].title,
          }
        ];
      }
    }
    return _finalEvents;
  }

  void sellProduct({
    required BuildContext context,
    required String EventName,
    required String EventDate,
    required String EventTime,
    required String Subject,
    required String Description,
    required String EventType,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      EventDataModel eventDataModel = EventDataModel(
          EventID: '',
          EventName: EventName,
          EventDate: EventDate,
          EventTime: EventTime,
          Subject: Subject,
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
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
