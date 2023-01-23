import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/features/event/model/ecent_try_model.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/event/model/event_data_model.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/event_screen.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class EventServices {
  void addNewEvent({
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
          Navigator.pushNamed(context, BottomBar.routeName);
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
}
