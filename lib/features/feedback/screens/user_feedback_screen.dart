import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/providers/user_provider.dart';

import '../model/feedback_model.dart';
import '../services/feedback_service.dart';

class UserFeedbackScreen extends StatefulWidget {
  static const String routeName = '/user-feedback-screen';

  const UserFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<UserFeedbackScreen> createState() => _UserFeedbackScreenState();
}

class _UserFeedbackScreenState extends State<UserFeedbackScreen> {
  final FeedbackService feedbackService = FeedbackService();
  List<FeedbackModel> feedbackModel = [];
  List<FeedbackModel> iniFeedbackModel = [];

  get adminFeedbackService => null;

  void deleteFeedback(String feedbackId) {
    feedbackService.updateFeedback(context: context, feedbackId: feedbackId);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Received Feedbacks"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: feedbackService.fetchAllFeedbacks(context),
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
              iniFeedbackModel = snapshot.data;
              for (int i = 0; i < iniFeedbackModel.length; i++) {
                if (iniFeedbackModel[i].userId == user &&
                    iniFeedbackModel[i].hide == false) {
                  feedbackModel.add(iniFeedbackModel[i]);
                }
              }
              return feedbackModel.isEmpty
                  ? const Center(
                      child: Text("No Feedbacks"),
                    )
                  : ListView.builder(
                      itemCount: feedbackModel.length,
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
                                          if (feedbackModel[index]
                                              .replyMessage
                                              .isEmpty) {
                                            showSnackBar(context,
                                                "You can't delete unless you get response");
                                          } else {
                                            deleteFeedback(feedbackModel[index]
                                                .feedbackId);
                                          }
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
                                child: Text(
                                  feedbackModel[index].replyMessage.isEmpty
                                      ? "NO Response Yet!!"
                                      : feedbackModel[index].replyMessage,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
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
