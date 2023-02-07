import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/service/discussion_service.dart';
import '../../../providers/user_provider.dart';
import '../model/discussion_model.dart';

class DiscussionScreen extends StatefulWidget {
  static const String routeName = '/discussion';

  const DiscussionScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final DiscussionService discussionService = DiscussionService();
  List<DiscussionModel> discussionModel = [];
  final _controller = TextEditingController();
  final _messages = <String>[];

  // void sendMessage() {
  //   setState(() {
  //     _messages.add(_controller.value.text);
  //     _controller.clear();
  //   });
  //   print("method called");
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessageData();
  }


  void getMessageData()async{
    discussionModel = await discussionService.getMessages(context);
    setState(() {

    });
  }

  void sendMessage(
      String userId, String userName, String userGroup, String userYear) {
    final now = DateTime.now();
    final format = DateFormat.jm();
    String time = format.format(now);
    // print(time);
    discussionService.sendMessage(
        context: context,
        message: _controller.text,
        messageTime: time,
        userId: userId,
        userName: userName,
        userGroup: userGroup,
        userYear: userYear);
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).user.firstName;
    final userId = Provider.of<UserProvider>(context).user.id;
    final userYear = Provider.of<UserProvider>(context).user.year;
    final userGroup = Provider.of<UserProvider>(context).user.group;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion Section'),
        centerTitle: true,
      ),
      body: Container(
            color: const Color.fromRGBO(242, 244, 255, 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: discussionModel.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        child: Row(
                          children: [
                            Column(
                              children:  [
                                const Icon(Icons.person_pin),
                                Text(discussionModel[index].userName),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Expanded(
                            //   child: Container(
                            //     padding: const EdgeInsets.all(10.0),
                            //     margin: const EdgeInsets.only(
                            //         bottom: 10.0, right: 30, left: 10, top: 5),
                            //     decoration: BoxDecoration(
                            //       // color: Colors.grey[200],
                            //       color: GlobalVariables.mainColor,
                            //       borderRadius: BorderRadius.circular(10.0),
                            //     ),
                            //     child: Text(
                            //       maxLines: 5,
                            //       _messages[index],
                            //       style: const TextStyle(
                            //         fontSize: 20,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    color: GlobalVariables.mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    maxLines: 6,
                                    discussionModel[index].message,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 220),
                                  child: Text(
                                    discussionModel[index].messageTime,
                                    style: const TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter a message',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        color: Colors.grey,
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if (_controller.text == "") {
                              showSnackBar(context, "Cannot send empty message");
                            } else {
                              // sendMessage();
                              sendMessage(userId, userName, userGroup, userYear);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),



      ),
    );
  }
}
