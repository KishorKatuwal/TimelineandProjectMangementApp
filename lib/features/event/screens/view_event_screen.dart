import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import '../../../providers/user_provider.dart';
import 'list_event_screen.dart';

class ViewEventScreen extends StatefulWidget {
  static const String routeName = '/view-event-screen';

  const ViewEventScreen({Key? key}) : super(key: key);

  @override
  State<ViewEventScreen> createState() => _ViewEventScreenState();
}

class _ViewEventScreenState extends State<ViewEventScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Events"),
        centerTitle: true,
      ),
      body: user.events.isEmpty
          ? const Center(
              child: Text("No Events are added"),
            )
          : ListView.builder(
              itemCount: user.events.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return SizedBox(
                  height: 100,
                  child: ListEventScreen(
                    index: index,
                  ),
                );
              })),
    );
  }
}
