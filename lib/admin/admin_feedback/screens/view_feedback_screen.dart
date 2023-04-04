import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/screens/reply_feedback_screen.dart';

import '../../../features/feedback/model/feedback_model.dart';
import '../admin_feedback_service/admin_feedback_service.dart';

class ViewFeedbackScreen extends StatefulWidget {
  static const String routeName = '/view-feedback-screen';

  const ViewFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<ViewFeedbackScreen> createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  final AdminFeedbackService adminFeedbackService = AdminFeedbackService();
  List<FeedbackModel> feedbackModel = [];

  void deleteFeedback(FeedbackModel feedback, int index) {
    adminFeedbackService.deleteFeedback(
        context: context,
        feedbackModel: feedback,
        onSuccess: () {
          //yo index chei tala builder bata aako ho
          feedbackModel.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Received Feedbacks"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: adminFeedbackService.fetchAllFeedbacks(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occurred: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text("No feedbacks are received yet!!"),
              );
            } else {
              feedbackModel = snapshot.data;
              return ListView.builder(
                  itemCount: feedbackModel.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            color: Colors.blueGrey,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "${feedbackModel[index].feedbackType}  ${feedbackModel[index].replyDate}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteFeedback(
                                          feedbackModel[index], index);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            feedbackModel[index].userEmail,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, left: 5, bottom: 15),
                            child: Text(
                              feedbackModel[index].description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, left: 5, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  feedbackModel[index].replyStatus
                                      ? "Already Replied"
                                      : "Not Replied",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                feedbackModel[index].replyStatus
                                    ? Container()
                                    : TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReplyFeedbackScreen(
                                                feedbackID: feedbackModel[index]
                                                    .feedbackId,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text("Reply")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
