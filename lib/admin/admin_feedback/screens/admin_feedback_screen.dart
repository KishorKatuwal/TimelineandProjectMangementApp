import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/admin_feedback_service/admin_feedback_service.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/model/discussion_model.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/model/feedback_model.dart';

import '../../../constants/global_variables.dart';

class AdminFeedbackScreen extends StatefulWidget {
  static const String routeName = '/admin-feedback-screen';

  const AdminFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<AdminFeedbackScreen> createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen> {
  final AdminFeedbackService adminFeedbackService = AdminFeedbackService();
  List<FeedbackModel> feedbackModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData()async{
    feedbackModel = await adminFeedbackService.fetchAllProducts(context);
    print(feedbackModel.length);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Feedback"),
      ),
      body: GridView.count(
          padding: const EdgeInsets.all(15),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Message",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.self_improvement,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Improvement",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.lightbulb_outline_sharp,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Suggestions",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.question_mark_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Questions",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "Bug-Report",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.white,
                        size: 36,
                      ),
                      Text(
                        "New Feature",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  )),
            ),
          ]),
    );
  }
}
