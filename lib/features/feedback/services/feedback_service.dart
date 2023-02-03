import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/model/feedback_model.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class FeedbackService {
  void addNewEvent({
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
          description: description);

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-event'),
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
}
