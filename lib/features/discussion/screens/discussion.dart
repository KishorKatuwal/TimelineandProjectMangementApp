import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';

class Discussion extends StatefulWidget {
  static const String routeName = '/discussion';

  const Discussion({Key? key}) : super(key: key);

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  final _controller = TextEditingController();
  final _messages = <String>[];

  void _sendMessage() {
    setState(() {
      _messages.add(_controller.value.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    // padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.person_pin),
                            Text("Kishor"),
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
                                _messages[index],
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 220),
                              child: Text(
                                "12:00 AM",
                                style: TextStyle(color: Colors.black45),
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
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        if (_controller.text == "") {
                          showSnackBar(context, "Cannot send empty message");
                        } else {
                          _sendMessage;
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
