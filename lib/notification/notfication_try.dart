import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/services/schedules_service.dart';
import 'package:timelineandprojectmanagementapp/notification/notification_service.dart';

class NotificationTryScreen extends StatefulWidget {
  const NotificationTryScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTryScreen> createState() => _NotificationTryScreenState();
}

class _NotificationTryScreenState extends State<NotificationTryScreen> {
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
                notificationService.showNotificationNow(
                    0, "This is title", "THis is body");
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
                      "Class Notification",
                      "This is my first class Notification");
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
              text: "Cancel All notifications",
              onTap: () {
                notificationService.cancelAllNotification();
              }),
        ],
      ),
    );
  }
}
