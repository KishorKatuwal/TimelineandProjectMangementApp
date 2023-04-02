import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

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
    // final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  //cancel all notification
  void cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
  void cancelAllNotificationById(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
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

  void showNotificationNow(int id) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      id,
      "Class Information",
      "Slide up to See class details",
      notificationDetails,
    );
  }

  //method for sending notification weekly
  Future<void> scheduleNotificationForClass(
      int id,
      int weekDay,
      int hour,
      int minute,
      String subjectName,
      String time,
      String location,
      String teacherName,
      String classType) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      '<br>Subject : $subjectName<br>'
      '<br>Time : $time<br>'
      '<br>ClassRoom : $location<br>'
      '<br>Teacher :  $teacherName<br>'
      '<br>Class Type :  $classType<br>',
      htmlFormatBigText: true,
      contentTitle: '<b>Class Information<b>',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );
    const String channelID = 'ccc';
    const String channelDesc = '103';
    const String channelName = '102';
    var androidNotificationChannel = const AndroidNotificationChannel(
      channelID,
      channelName,
      description: channelDesc,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Class Information",
        "Slide up to seeDetails",
        instanceOFClassTime(hour, minute, weekDay),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelID,
            channelName,
            channelDescription: channelDesc,
            styleInformation: bigTextStyleInformation,
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  //delete class notifications
  Future<void> deleteNotificationsByChannelId(String channelId) async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelId);
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
}
