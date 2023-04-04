import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/screens/view_feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/model/feedback_model.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class AdminFeedbackService {
  //getting all the feedbacks from the database
  Future<List<FeedbackModel>> fetchAllFeedbacks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<FeedbackModel> feedbackList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-feedback'), headers: {
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

//deleting feedback
  void deleteFeedback(
      {required BuildContext context,
        required FeedbackModel feedbackModel,
        required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': feedbackModel.feedbackId,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      print("Failed on admin feedback service catch");
      showSnackBar(context, e.toString());
    }
  }


  //replying feedback message
  void replyFeedback({
    required BuildContext context,
    required String feedbackId,
    required String replyMessage,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/admin/api/reply-feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'feedbackId': feedbackId,
          'replyMessage': replyMessage,
          'replyStatus': true,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully replied!!");
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context, ViewFeedbackScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }




}
