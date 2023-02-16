import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/feedback/model/feedback_model.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../features/discussion/model/discussion_model.dart';
import '../../../providers/user_provider.dart';

class AdminFeedbackService {
  //getting all the product from the database
  Future<List<FeedbackModel>> fetchAllProducts(BuildContext context) async {
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
      print("I am here");
    }
    return feedbackList;
  }
}
