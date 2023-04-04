import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/admin_feedback_service/admin_feedback_service.dart';

import '../../../common/widgets/custom_button.dart';

class ReplyFeedbackScreen extends StatefulWidget {
  final String feedbackID;

  const ReplyFeedbackScreen({Key? key, required this.feedbackID})
      : super(key: key);

  @override
  State<ReplyFeedbackScreen> createState() => _ReplyFeedbackScreenState();
}

class _ReplyFeedbackScreenState extends State<ReplyFeedbackScreen> {
  final _replyController = TextEditingController();
  final _replyFormKey = GlobalKey<FormState>();
  final AdminFeedbackService adminFeedbackService = AdminFeedbackService();

  void replyMessage() {
    adminFeedbackService.replyFeedback(
        context: context,
        feedbackId: widget.feedbackID,
        replyMessage: _replyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reply Feedback"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Form(
          key: _replyFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _replyController,
                decoration: const InputDecoration(
                  label: Text(
                    "Reply Message",
                    style: TextStyle(fontSize: 22),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Your Reply Message";
                  }
                  return null;
                },
                maxLines: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Reply Feedback",
                onTap: () {
                  if (_replyFormKey.currentState!.validate()) {
                    replyMessage();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
