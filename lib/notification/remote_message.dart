import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ShowMessageData{
  // ignore: empty_constructor_bodies
  messageData(){
 FirebaseMessaging.onMessage.listen((RemoteMessage message)async{
print('.....................OnMessage................');
print('OnMessage ${message.notification!.title.toString()}/${message.notification!.body.toString()}');
BigTextStyleInformation bigTextStyleInformation=BigTextStyleInformation(message.notification!.body.toString(),htmlFormatBigText: true,
contentTitle: message.notification!.title.toString(),htmlFormatTitle: true);
AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails('KB', 'KB',importance: Importance.high,styleInformation: bigTextStyleInformation,priority: Priority.high,playSound: true);
NotificationDetails notificationDetails=NotificationDetails(android: androidNotificationDetails);
await FlutterLocalNotificationsPlugin().show(0, message.notification!.title.toString(), 
message.notification!.body.toString(), notificationDetails,payload: message.data['body']);
 });
  }
}