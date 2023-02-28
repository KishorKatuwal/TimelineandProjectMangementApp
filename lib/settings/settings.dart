import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';

import '../features/schedules/services/schedules_service.dart';
import '../notification/notification_service.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/setting-screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final NotificationService notificationService = NotificationService();
  final SchedulesService schedulesService = SchedulesService();
  late final String group;
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    notificationService.initialiseNotifications();
    getData(context);
  }

  void getData(BuildContext context) async {
    _data = await schedulesService.forNotification(context);
    setState(() {});
  }

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
                onPressed: () {
                  for (int i = 0; i < _data.length; i++) {
                    notificationService.scheduleNotificationForClass(
                      i,
                      _data[i][11],
                      _data[i][9],
                      _data[i][10],
                      _data[i][4],
                      _data[i][1],
                      _data[i][7] + "" + _data[i][8],
                      _data[i][5],
                      _data[i][3],
                    );
                  }
                },
                child: Text(
                  "Get Notification for your Group $group",
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {
                  for (int i = 0; i < 10; i++) {
                    notificationService.cancelAllNotificationById(i);
                  }
                },
                child: Text(
                  "Stop getting Notification for Group $group",
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {
                  notificationService.cancelAllNotification();
                },
                child: const Text(
                  "Cancel all Notifications",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
               Text(
                textAlign: TextAlign.justify,
                "NOTE: If you don't get notification for your daily classes. Try cancelling class "
                "notification once and get the notifications again",
                style: TextStyle(color: Colors.blueGrey),
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
