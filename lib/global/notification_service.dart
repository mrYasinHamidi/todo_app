import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/features/tasks/data/models/app_task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  static Future<void> cancel(AppTask task) => _notificationsPlugin.cancel(task.getNotificationId());

  static Future<void> scheduleNotification(AppTask task) =>
      task.dueDate == null
          ? Future.value()
          : task.dueDate!.isBefore(DateTime.now())
          ? Future.value()
          : _notificationsPlugin.zonedSchedule(
            task.getNotificationId(),
            'Time to done your Task',
            task.description,
            tz.TZDateTime.from(task.dueDate!, tz.local),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'todo_channel',
                'Task Reminders',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.alarmClock,
          );
}
