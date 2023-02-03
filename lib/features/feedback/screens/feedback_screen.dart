import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/screens/feedback_categorycard.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/services/feedback_service.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfiels.dart';
import '../../../providers/user_provider.dart';

class FeedbackScreen extends StatefulWidget {
  static const String routeName = '/feedback-screen';

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _provideFeedbackFormKey = GlobalKey<FormState>();
  final _userEmailController = TextEditingController();
  final _feedbackTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FeedbackService feedbackService = FeedbackService();
  String category = "Message";

  _setCategory(String newCategory) {
    setState(() {
      category = newCategory;
      _feedbackTypeController.text=category;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
    _feedbackTypeController.dispose();
    _userEmailController.dispose();
  }


  void provideFeedback(String userId){
    feedbackService.provideFeedback(
        context: context,
        userId: userId,
        userEmail: _userEmailController.text,
        feedbackType: _feedbackTypeController.text,
        description: _descriptionController.text);
  }




  @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserProvider>(context).user.id;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Feedback"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Form(
                key: _provideFeedbackFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        controller: _userEmailController, hintText: "Email"),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Feedback Type",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _setCategory('Message');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'Message',
                            isActive: category == 'Message',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setCategory('Improvement');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'Improvement',
                            isActive: category == 'Improvement',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setCategory('Suggestions');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'Suggestions',
                            isActive: category == 'Suggestions',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setCategory('Questions');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'Questions',
                            isActive: category == 'Questions',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setCategory('Bug Report');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'Bug Report',
                            isActive: category == 'Bug Report',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setCategory('New Feature');
                          },
                          child: FeedbackCategoryCard(
                            categoryText: 'New Feature',
                            isActive: category == 'New Feature',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Explain in detail",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: _descriptionController,
                      hintText: "Feedback Description",
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                      text: "Provide Feedback",
                      onTap: () {
                        if (_provideFeedbackFormKey.currentState!.validate()) {
                          print(_feedbackTypeController.text);
                          provideFeedback(id);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
