import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';

import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/setting-screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<UserProvider>(context).user.group;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: GlobalVariables.backgroundColour,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notification",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey),
              ),
              const Divider(
                color: Colors.black45,
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Get Notification for your Group $group",
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Stop getting Notification for Group $group",
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Cancel all Notifications",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Divider(
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
