import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime now = DateTime.now();
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
    setState(() {});
  }

  void connect() {
    // Create a socket instance with the specified URI and options
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    // Connect to the server
    socket!.connect();
    // Listen for the "sendMsgServer" event from the server
    socket!.on("sendMsgServer", (msg) {
      print(msg);
      // Check if the widget is still mounted before updating the UI
      if (mounted) {
        setState(() {
          getPreviousMessage();
        });
      }
    });
  }

//method to send message
  void sendMsg(String msg, String userName, String userId, String userGroup,
      String userYear) {
    socket!.emit('send', {
      'messageId': '',
      'message': msg,
      'messageTime': DateFormat('hh:mm a').format(now),
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
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
                itemCount: discussionModel.length,
                itemBuilder: (context, index) {
                  if (discussionModel[index].userId == user.id) {
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
                      sendMsg(_messageController.text, user.firstName, user.id,
                          user.group, user.year);
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
