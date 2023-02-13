import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/model/discussion_model.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class DiscussionService {
  void sendMessage({
    required BuildContext context,
    required String message,
    required String messageTime,
    required String userId,
    required String userName,
    required String userGroup,
    required String userYear,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      DiscussionModel discussionModel = DiscussionModel(
          messageId: "",
          message: message,
          messageTime: messageTime,
          userId: userId,
          userName: userName,
          userGroup: userGroup,
          userYear: userYear);

      http.Response res = await http.post(
        Uri.parse('$uri/api/send-message'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: discussionModel.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // showSnackBar(context, 'Message Successfully Provided!');
          // Navigator.pushNamed(context, Discussion.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // method for fetching data
  Future<List<DiscussionModel>> getMessages(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<DiscussionModel> messageList = [];
    // List<DiscussionModel>? reversedList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-messages'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      // discussionProvider.setDiscussion(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // convert received json response into product model
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              messageList.add(DiscussionModel.fromJson(
                  jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return messageList.reversed.toList();
  }
}
