import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/services/schedules_service.dart';
import 'package:timelineandprojectmanagementapp/notification/calling_method.dart';
import 'package:timelineandprojectmanagementapp/notification/notification_service.dart';

class NotificationTryScreen extends StatefulWidget {
  const NotificationTryScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTryScreen> createState() => _NotificationTryScreenState();
}

class _NotificationTryScreenState extends State<NotificationTryScreen> {
  final NotificationService notificationService = NotificationService();
  final CallingMethod callingMethod = CallingMethod();
  final SchedulesService schedulesService = SchedulesService();
  final Random random= Random.secure();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Try"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Show Notification",
              onTap: () {
                notificationService.showNotificationNow(50);
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Schedule Notification",
              onTap: () {
                notificationService.scheduleNotificationOnce(
                    16, 2023, 2, 12, 10, 38, "THis is asfsd", "sfsadfsad");
                print("Schedule notification button pressed");
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Set Notification for Class",
              onTap: () {
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
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(text: "Print pending notifications", onTap: () {}),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Print Time",
              onTap: () {
                notificationService.printTime();
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Cancel Class Notifications",
              onTap: () {
                notificationService.deleteNotificationsByChannelId('ccc');
                print("nothing happened");
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Printing random number",
              onTap: () {
                for(int i=0; i<10;i++){
                  int randomNumber = random.nextInt(31)+20;
                  print("$i : $randomNumber");
                }

              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Cancel All notifications",
              onTap: () {
                notificationService.cancelAllNotification();
              }),
        ],
      ),
    );
  }
}
