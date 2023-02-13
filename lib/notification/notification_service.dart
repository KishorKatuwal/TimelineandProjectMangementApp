import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    _configureLocalTimeZone();
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    List<PendingNotificationRequest> pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print("Pending Notification ${pendingNotifications.length}");
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
  }

  //cancel all notification
  void cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  ktmTime() {
    var kathmandu = tz.getLocation('Asia/Kathmandu');
    var now = tz.TZDateTime.now(kathmandu);
    return now;
  }

  ktmLocation() {
    var kathmandu = tz.getLocation('Asia/Kathmandu');
    return kathmandu;
  }

  void printTime() {
    // var now = tz.TZDateTime.now(tz.local);
    var kathmandu = tz.getLocation('Asia/Kathmandu');
    var now = tz.TZDateTime.now(kathmandu);
    print(now);
  }

  void scheduleNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            priority: Priority.high, importance: Importance.max);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.weekly,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  void showNotificationNow(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            priority: Priority.high, importance: Importance.max);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  //method for sending notification weekly
  Future<void> scheduleNotificationForClass(int id, int weekDay, int hour,
      int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        instanceOFClassTime(hour, minute, weekDay),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly notification channel id',
              'weekly notification channel name',
              channelDescription: 'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime instanceOFClassTime(int hour, int minute, int weekDay) {
    tz.TZDateTime scheduledDate = instanceOfClassDateTime(hour, minute);
    while (scheduledDate.weekday != weekDay) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime instanceOfClassDateTime(int hour, int minute) {
    final tz.TZDateTime now = ktmTime();
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        ktmLocation(), now.year, now.month, now.day, hour, minute, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  //method for setting notification for class
  void showNotificationForClass(
      int id, int hour, int minute, int classDay) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'weekly scheduled notification title',
        'weekly scheduled notification body',
        _nextInstanceOfMondayTenAM(hour, minute, classDay),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly notification channel id',
              'weekly notification channel name',
              channelDescription: 'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  //method for getting notification once only
  void scheduleNotificationOnce(int id, int year, int month, int day, int hour,
      int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      convertTimeForOnce(year, month, day, hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'once notification channel id', 'once notification channel name',
            channelDescription: 'once notification description'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidAllowWhileIdle: true,
    );
  }

  tz.TZDateTime convertTimeForOnce(
      int year, int month, int day, int hour, int minute) {
    // final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime now = ktmTime();
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(ktmLocation(), year, month, day, hour, minute, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  //method for sending notification daily
  Future<void> scheduleDailyEventNotification(
      int id, int hour, int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        instanceOfDaily(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime instanceOfDaily(int hour, int minute) {
    final tz.TZDateTime now = ktmTime();
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        ktmLocation(), now.year, now.month, now.day, hour, minute, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  //method for sending notification weekly
  Future<void> scheduleWeeklyNotification(int id, int year, int month, int day,
      int weekDay, int hour, int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        instanceOFTime(year, month, day, weekDay, hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly notification channel id',
              'weekly notification channel name',
              channelDescription: 'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  //method for sending notification monthly
  Future<void> scheduleMonthlyNotification(int id, int year, int month, int day,
      int weekDay, int hour, int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        instanceOFTime(year, month, day, weekDay, hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('monthly notification channel id',
              'monthly notification channel name',
              channelDescription: 'monthly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  }

  //method for sending notification yearly
  Future<void> scheduleYearlyNotification(int id, int year, int month, int day,
      int weekDay, int hour, int minute, String title, String body) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        instanceOFTime(year, month, day, weekDay, hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('yearly notification channel id',
              'yearly notification channel name',
              channelDescription: 'yearly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime instanceOFTime(
      int year, int month, int day, int weekday, int hour, int minute) {
    tz.TZDateTime scheduledDate =
        instanceOfDateTime(year, month, day, hour, minute);
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime instanceOfDateTime(
      int year, int month, int day, hour, int minute) {
    final tz.TZDateTime now = ktmTime();
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(ktmLocation(), year, month, day, hour, minute, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM(int hour, int minute, int classDay) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM(hour, minute);
    while (scheduledDate.weekday != classDay) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minute) {
    late final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
