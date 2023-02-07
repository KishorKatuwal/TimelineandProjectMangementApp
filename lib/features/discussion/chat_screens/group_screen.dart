import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timelineandprojectmanagementapp/features/discussion/chat_screens/other_message.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/chat_screens/own_message.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/service/discussion_service.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../model/discussion_model.dart';

class GroupScreen extends StatefulWidget {
  static const String routeName = '/group-screen';

  const GroupScreen({Key? key}) : super(key: key);
  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final DiscussionService discussionService = DiscussionService();
  IO.Socket? socket;
  List<DiscussionModel> discussionModel = [];
  final _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousMessage();
  }

  void getPreviousMessage() async {
    discussionModel = await discussionService.getMessages(context);
    connect();
    setState(() {
    });
  }

  void connect() {
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    print("we are here");
    socket!.on("sendMsgServer", (msg) {
      print(msg);
      print("reached here");
      if (mounted) {
        setState(() {
          getPreviousMessage();
        });
      }

    });
  }

  void sendMsg(String msg, String userName, String userId, String userGroup,
      String userYear) {
    socket!.emit('send', {
      'messageId': '',
      'message': msg,
      'messageTime': "myTime",
      'userId': userId,
      'userName': userName,
      'userGroup': userGroup,
      'userYear': userYear,
    });
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).user.firstName;
    final userId = Provider.of<UserProvider>(context).user.id;
    final userYear = Provider.of<UserProvider>(context).user.year;
    final userGroup = Provider.of<UserProvider>(context).user.group;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: discussionModel.length,
                itemBuilder: (context, index) {
                  if (discussionModel[index].userId == userId) {
                    return OwnMessage(
                        message: discussionModel[index].message,
                        userName: discussionModel[index].userName);
                  } else {
                    return OtherMessage(
                        message: discussionModel[index].message,
                        userName: discussionModel[index].userName);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                )),
                IconButton(
                  onPressed: () {
                    if (_messageController.text.isEmpty) {
                    } else {
                      sendMsg(_messageController.text, userName, userId,
                          userGroup, userYear);
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
