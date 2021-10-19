import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:untitled3/Observables/NotificationObservable.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    final notificationObserver = Provider.of<NotificationObserver>(context);

    bool id;
    return Observer(
        builder: (_) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(18, 0, 0, 20)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Notes Notifications",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: Colors.black87,
                        height: 20,
                        thickness: 2,
                      ),
                      SwitchListTile(
                        value:id = false,
                        onChanged: (value) {

                        },
                        title: Text("Turn on Notification for Notes",style: TextStyle(fontSize: 16),),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Activities Notifications",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: Colors.black87,
                        height: 20,
                        thickness: 2,
                      ),
                      SwitchListTile(
                        value: notificationObserver.onWalking,
                        onChanged: (value) async {
                          notificationObserver.NotificationWalk(value);
                          print(notificationObserver.onWalking);
                          if(!notificationObserver.onWalking) {
                            await cancelWalkNotification();
                          }else{
                            repeatNotificationWalk();
                          }
                        },
                        title: Text("Turn on Notification for hourly Walk",style: TextStyle(fontSize: 16),),
                      ),
                      SwitchListTile(
                        value: notificationObserver.onWater,
                        onChanged: (value1) async {
                          notificationObserver.NotificationWater(value1);
                          print(notificationObserver.onWater);
                          if(!notificationObserver.onWater) {
                            await cancelWaterNotification();
                          }else{
                            repeatNotificationWater();
                          }
                        },
                        title: Text("Turn on Notification for hourly Water",style: TextStyle(fontSize: 16),),
                      ),
                      SwitchListTile(
                        value: notificationObserver.Bathroom,
                        onChanged: (value2) async {
                          notificationObserver.NotificationBathroom(value2);
                          print(notificationObserver.Bathroom);
                          if(!notificationObserver.Bathroom) {
                            await cancelbathNotification();
                          }else{
                            repeatNotificationBathroom();
                          }
                        },
                        title: Text("Turn on Notification for Bathroom",style: TextStyle(fontSize: 16),),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  displayNotification(String match) async {
    notificationsPlugin.zonedSchedule(
        0,
        'Remember',
        match,
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 5),
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
              'channel id', 'channel name'),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}

void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('my_logo');
  var initializeSetting = InitializationSettings(android: initializeAndroid);
  await notificationsPlugin.initialize(initializeSetting);
}

repeatNotificationWater() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 1',
    'CHANNEL_NAME 1',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    1,
    'WATER',
    'Please drink water',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

repeatNotificationWalk() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 2',
    'CHANNEL_NAME 2',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    2,
    'Walk',
    'Please take a walk',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}
repeatNotificationBathroom() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 3',
    'CHANNEL_NAME 3',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    3,
    'Bathroom',
    'Please Go to the bathroom',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}
Future<void> cancelWaterNotification() async {
  await notificationsPlugin.cancel(1);
}

Future<void> cancelWalkNotification() async {
  await notificationsPlugin.cancel(2);
}
Future<void> cancelbathNotification() async {
  await notificationsPlugin.cancel(3);
}

