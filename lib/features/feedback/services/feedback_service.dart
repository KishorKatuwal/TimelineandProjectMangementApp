import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/model/feedback_model.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/screens/user_feedback_screen.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class FeedbackService {
  void provideFeedback({
    required BuildContext context,
    required String userId,
    required String userEmail,
    required String feedbackType,
    required String description,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      FeedbackModel feedbackModel = FeedbackModel(
        feedbackId: '',
        userId: userId,
        userEmail: userEmail,
        feedbackType: feedbackType,
        description: description,
        replyDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString().replaceAll("00:00:00.000", ""),
        replyStatus: false,
        hide: false,
        replyMessage: "",
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/give-feedback'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: feedbackModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Feedback Successfully Provided!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get feedbacks
  Future<List<FeedbackModel>> fetchAllFeedbacks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<FeedbackModel> feedbackList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/get-feedback'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              feedbackList.add(FeedbackModel.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return feedbackList;
  }


  //hiding feedback from user when delete button is pressed
  void updateFeedback({
    required BuildContext context,
    required String feedbackId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-user-feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'feedbackId': feedbackId,
          'hide': true,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully deleted!!");
            Navigator.pop(context);
            Navigator.pushNamed(context, UserFeedbackScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }







}
